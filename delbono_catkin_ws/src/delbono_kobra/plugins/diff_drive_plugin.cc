/*
* Differential drive plugin that controls the skidsteering
* of the kobra robot
*
* Code taken from:
* http://gazebosim.org/tutorials?tut=plugins_model&cat=write_plugin
* http://gazebosim.org/tutorials?tut=guided_i6
* http://gazebosim.org/tutorials?tut=guided_i5
*
* Changes done by Alex Delbono
*
*/

#include "ros/ros.h"
#include "ros/callback_queue.h"
#include "ros/subscribe_options.h"
#include "geometry_msgs/Twist.h"
#include <nav_msgs/Odometry.h>
#include <tf/transform_broadcaster.h>
#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdio.h>
#include <thread>

#define EULER       1
#define RUNGE_KUTTA 2
#define EXACT       3

namespace gazebo
{
  class DiffDriveController : public ModelPlugin
  {
    // Pointer to the model
    private: physics::ModelPtr model;
    // Pointer to the update event connection
    //private: event::ConnectionPtr updateConnection;

    //////////////////////////////////////////////////////////////////
    //Gazebo elements
    private: physics::JointPtr lfjoint, rfjoint, lbjoint, rbjoint;
    private: common::PID lfpid, rfpid, lbpid, rbpid;
    private: nav_msgs::Odometry prevMsg;



    ///////////////////////////////////////////////////////////////////
    //Ros elements
    private: std::unique_ptr<ros::NodeHandle> rosNode;
    private: ros::Subscriber rosSub;
    private: ros::Publisher rosSimOdomPub;
    private: ros::Publisher rosOdomPub;
    private: ros::CallbackQueue rosQueue;
    private: std::thread rosQueueThread;
    private: event::ConnectionPtr updateConnection;

    private: int integrationMethod;

    ///////////////////////////////////////////////////////////////////
    //Constants of the robot
    private: const float wheelRadius = 0.0725;
    private: const float halfTrack = 0.2475;

    //Conversion functions
    private: inline float fromRobotVelToLeftAngVel (float linvel, float angvel)
    {
      return (linvel - angvel * halfTrack) / wheelRadius;
    }

    private: inline float fromRobotVelToRightAngVel (float linvel, float angvel)
    {
      return (linvel + angvel * halfTrack) / wheelRadius;
    }

    private: inline float fromWheelAngVelToRobotAngular (float leftVel, float rightVel)
    {
      return ((rightVel -leftVel) *wheelRadius) /(2*halfTrack);
    }

    private: float fromWheelAngVelToRobotLinear (float leftVel, float rightVel)
    {
      return ((leftVel + rightVel) * wheelRadius)/2;
    }

    //Handle the commands from the outside
    public: void handleCmdVel(const geometry_msgs::Twist::ConstPtr &msg)
    {
      geometry_msgs::Twist vel = *msg;

      //Debug purposes
      //printf("Message received!\n");

      // Set the joint's target velocity.
      float leftVel = fromRobotVelToLeftAngVel(vel.linear.x, vel.angular.z);
      float rightVel = fromRobotVelToRightAngVel(vel.linear.x, vel.angular.z);


      this->model->GetJointController()->SetVelocityTarget(
          this->lfjoint->GetScopedName(), leftVel);
      this->model->GetJointController()->SetVelocityTarget(
          this->lbjoint->GetScopedName(), leftVel);

      this->model->GetJointController()->SetVelocityTarget(
          this->rfjoint->GetScopedName(), rightVel);
      this->model->GetJointController()->SetVelocityTarget(
          this->rbjoint->GetScopedName(), rightVel);
    }

    /// brief ROS helper function that processes messages
    private: void QueueThread()
    {
      static const double timeout = 0.01;
      while (this->rosNode->ok())
      {
        this->rosQueue.callAvailable(ros::WallDuration(timeout));
      }
    }

    //Function executed on load
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/)
    {
      // Store the pointer to the model
      this->model = _parent;

      //Print debug info
      printf("%s\n", ("Differential Drive Controller loaded on " +
                                  this->model->GetName()).c_str());

      ////////////////////////////////////////////////////////////////////
      //INITIALIZE GAZEBO ELEMENTS AND PIDS


      this->lfjoint = this->model->GetJoints()[0];
      this->rfjoint = this->model->GetJoints()[1];
      this->lbjoint = this->model->GetJoints()[2];
      this->rbjoint = this->model->GetJoints()[3];

      // Setup P-controllers, with a gain of 0.1.
      this->lfpid = common::PID(0.5, 0, 0);
      this->rfpid = common::PID(0.5, 0, 0);
      this->lbpid = common::PID(0.5, 0, 0);
      this->rbpid = common::PID(0.5, 0, 0);

      // Apply the P-controllers to the joints.
      this->model->GetJointController()->SetVelocityPID(
      this->lfjoint->GetScopedName(), this->lfpid);
      this->model->GetJointController()->SetVelocityPID(
      this->rfjoint->GetScopedName(), this->rfpid);
      this->model->GetJointController()->SetVelocityPID(
      this->lbjoint->GetScopedName(), this->lbpid);
      this->model->GetJointController()->SetVelocityPID(
      this->rbjoint->GetScopedName(), this->rbpid);

      prevMsg.header.stamp = ros::Time(0,0);
      prevMsg.header.frame_id = "odom";
      prevMsg.child_frame_id = "base_link";

      prevMsg.pose.pose.position.x = this->model->GetWorldPose().pos.x;
      prevMsg.pose.pose.position.y = this->model->GetWorldPose().pos.y;
      prevMsg.pose.pose.position.z = this->model->GetWorldPose().pos.z;

      gazebo::math::Quaternion gq(this->model->GetWorldPose().rot);
      geometry_msgs::Quaternion odom_quat =
         tf::createQuaternionMsgFromYaw(gq.GetYaw());
      prevMsg.pose.pose.orientation = odom_quat;


      prevMsg.twist.twist.linear.x = 0;
      prevMsg.twist.twist.linear.y = 0;
      prevMsg.twist.twist.angular.z = 0;

      /////////////////////////////////////////////////////////////////////
      //ROS OPERATIONS

      // Initialize ros, if it has not already been initialized
      if (!ros::isInitialized()){
        int argc = 0;
        char ** argv = NULL;
        ros::init(argc, argv, "gazebo_diff_drive", ros::init_options::NoSigintHandler);
      }
      // Create the ROS node
      rosNode.reset(new ros::NodeHandle("gazebo_diff_drive"));

      if(!ros::param::get("/integration_method", integrationMethod))
        integrationMethod = EULER;



      //////////////////////////////////////////////////////////////////
      //INITIALIZE SUBSCRIBER
      // Subscribe to /DelbonoKobra/cmd_velocity topic
      ros::SubscribeOptions so = ros::SubscribeOptions::create<geometry_msgs::Twist>(
            "/" + this->model->GetName() + "/cmd_velocity", 10,
            boost::bind(&DiffDriveController::handleCmdVel, this, _1),
            ros::VoidPtr(), &this->rosQueue);

      this->rosSub = this->rosNode->subscribe(so);

      // Spin up the queue helper thread.
      this->rosQueueThread =
      std::thread(std::bind(&DiffDriveController::QueueThread, this));


      ////////////////////////////////////////////////////////////////////
      //INITIALIZE PUBLISHER
      //Create the odometry topics
      this->rosOdomPub = this->rosNode->advertise<nav_msgs::Odometry>(
          "/" + this->model->GetName() + "/odometry", 50);

      this->rosSimOdomPub = this->rosNode->advertise<nav_msgs::Odometry>(
          "/" + this->model->GetName() + "/simulator_odometry", 50);

      // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          boost::bind(&DiffDriveController::OnUpdate, this, _1));

    }



    // Called by the world update start event
    public: void OnUpdate(const common::UpdateInfo & _info)
    {
      ros::spinOnce();

      //Publish the odometry using one of the three methods
      nav_msgs::Odometry odom;

      odom.header.stamp = ros::Time(_info.simTime.Double());
      odom.header.frame_id = "odom";
      odom.child_frame_id = "delbono_odometry";

      ///////////////////////////////////////////////////////////////
      //Integration

      switch (integrationMethod)
      {
        case(EULER):
          euler(odom);
          break;
        case(RUNGE_KUTTA):
          runge_kutta(odom);
          break;
        case(EXACT):
          exact(odom);
          break;
        default:
          ROS_ERROR("Integration method not valid");
          exit(-1);
      }

      //Set the message velocity fields
      float lvel = this->lfjoint->GetVelocity(1);
      float rvel = this->rfjoint->GetVelocity(1);

      odom.pose.pose.position.z = this->model->GetWorldPose().pos.z;
      odom.twist.twist.linear.x = fromWheelAngVelToRobotLinear(lvel, rvel);
      odom.twist.twist.angular.z = fromWheelAngVelToRobotAngular(lvel, rvel);

      //set the old position
      setOldOdometry(odom);

      //Publish the message
      this->rosOdomPub.publish(odom);

      //Create the exact odometry
      nav_msgs::Odometry ex_odom;
      ex_odom.header.stamp = ros::Time::now();
      ex_odom.header.frame_id = "odom";
      ex_odom.child_frame_id = "simulator_odometry";

      ex_odom.pose.pose.position.x = this->model->GetWorldPose().pos.x;
      ex_odom.pose.pose.position.y = this->model->GetWorldPose().pos.y;
      ex_odom.pose.pose.position.z = this->model->GetWorldPose().pos.z;

      gazebo::math::Quaternion gq(this->model->GetWorldPose().rot);
      geometry_msgs::Quaternion odom_quat =
         tf::createQuaternionMsgFromYaw(gq.GetYaw());
      ex_odom.pose.pose.orientation = odom_quat;

      ex_odom.twist.twist.linear.x = this->model->GetWorldLinearVel().x;
      ex_odom.twist.twist.linear.y = this->model->GetWorldLinearVel().y;
      ex_odom.twist.twist.linear.z = this->model->GetWorldLinearVel().z;
      ex_odom.twist.twist.angular.x = this->model->GetWorldAngularVel().x;
      ex_odom.twist.twist.angular.y = this->model->GetWorldAngularVel().y;
      ex_odom.twist.twist.angular.z = this->model->GetWorldAngularVel().z;

      this->rosSimOdomPub.publish(ex_odom);
    }

    /////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////
    //Helper functions


    public: void euler(nav_msgs::Odometry & odom)
    {
      double prevRoll, prevPitch, prevYaw;
      tf::Quaternion q(prevMsg.pose.pose.orientation.x,
                       prevMsg.pose.pose.orientation.y,
                       prevMsg.pose.pose.orientation.z,
                       prevMsg.pose.pose.orientation.w);
      tf::Matrix3x3(q).getRPY(prevRoll, prevPitch, prevYaw);

      float dt = (odom.header.stamp- prevMsg.header.stamp).toSec();
      float dx = dt* prevMsg.twist.twist.linear.x * cos(prevYaw);
      float dy = dt* prevMsg.twist.twist.linear.x * sin(prevYaw);
      float dang = dt * prevMsg.twist.twist.angular.z;

      odom.pose.pose.position.x = prevMsg.pose.pose.position.x + dx;
      odom.pose.pose.position.y = prevMsg.pose.pose.position.y + dy;
      odom.pose.pose.position.z = prevMsg.pose.pose.position.z;

      odom.pose.pose.orientation = tf::createQuaternionMsgFromYaw(prevYaw + dang);

    }

    public: void runge_kutta(nav_msgs::Odometry & odom)
    {
      double prevRoll, prevPitch, prevYaw;
      tf::Quaternion q(prevMsg.pose.pose.orientation.x,
                       prevMsg.pose.pose.orientation.y,
                       prevMsg.pose.pose.orientation.z,
                       prevMsg.pose.pose.orientation.w);
      tf::Matrix3x3(q).getRPY(prevRoll, prevPitch, prevYaw);

      float dt = (odom.header.stamp- prevMsg.header.stamp).toSec();
      float dx = dt* prevMsg.twist.twist.linear.x *
                    cos(prevYaw + (dt*prevMsg.twist.twist.angular.z)/2);
      float dy = dt* prevMsg.twist.twist.linear.x *
                    sin(prevYaw + (dt*prevMsg.twist.twist.angular.z)/2);
      float dang = dt * prevMsg.twist.twist.angular.z;

      odom.pose.pose.position.x = prevMsg.pose.pose.position.x + dx;
      odom.pose.pose.position.y = prevMsg.pose.pose.position.y + dy;
      odom.pose.pose.position.z = prevMsg.pose.pose.position.z;

      odom.pose.pose.orientation = tf::createQuaternionMsgFromYaw(prevYaw + dang);
    }

    public: void exact(nav_msgs::Odometry & odom)
    {
      double prevRoll, prevPitch, prevYaw;
      tf::Quaternion q(prevMsg.pose.pose.orientation.x,
                       prevMsg.pose.pose.orientation.y,
                       prevMsg.pose.pose.orientation.z,
                       prevMsg.pose.pose.orientation.w);
      tf::Matrix3x3(q).getRPY(prevRoll, prevPitch, prevYaw);

      float dt = (odom.header.stamp- prevMsg.header.stamp).toSec();
      float dang = dt * prevMsg.twist.twist.angular.z;
      float newYaw = prevYaw + dang;

      float dx, dy;

      if(prevMsg.twist.twist.angular.z) {
        dx = (prevMsg.twist.twist.linear.x/prevMsg.twist.twist.angular.z) *
                                  (sin(newYaw) - sin(prevYaw));
        dy = (prevMsg.twist.twist.linear.x/prevMsg.twist.twist.angular.z) *
                                  (cos(newYaw) - cos(prevYaw));
      } else {
        dx = dt* prevMsg.twist.twist.linear.x * cos(prevYaw);
        dy = dt* prevMsg.twist.twist.linear.x * sin(prevYaw);
      }
      odom.pose.pose.position.x = prevMsg.pose.pose.position.x + dx;
      odom.pose.pose.position.y = prevMsg.pose.pose.position.y - dy;
      odom.pose.pose.position.z = prevMsg.pose.pose.position.z;

      odom.pose.pose.orientation = tf::createQuaternionMsgFromYaw(newYaw);
    }

    public: void setOldOdometry(nav_msgs::Odometry & odom)
    {
      prevMsg.header.stamp = odom.header.stamp;
      prevMsg.header.frame_id = odom.header.frame_id ;
      prevMsg.child_frame_id = odom.child_frame_id ;

      prevMsg.pose.pose.position.x = odom.pose.pose.position.x;
      prevMsg.pose.pose.position.y = odom.pose.pose.position.y;
      prevMsg.pose.pose.position.z = odom.pose.pose.position.z;

      prevMsg.pose.pose.orientation = odom.pose.pose.orientation ;

      prevMsg.twist.twist.linear.x = odom.twist.twist.linear.x ;
      prevMsg.twist.twist.linear.y = odom.twist.twist.linear.y;
      prevMsg.twist.twist.angular.z = odom.twist.twist.angular.z;
    }

  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(DiffDriveController)
}
