/*
* Camera plugin that controls the pan and tilt movements
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
#include "delbono_kobra/Ptz.h"
#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdio.h>
#include <thread>
#include <nav_msgs/Odometry.h>
#include <tf/transform_broadcaster.h>

namespace gazebo
{
  class CameraController : public ModelPlugin
  {
    // Pointer to the model
    private: physics::ModelPtr model;
    // Pointer to the update event connection
    //private: event::ConnectionPtr updateConnection;

    //////////////////////////////////////////////////////////////////
    //Gazebo elements
    private: physics::JointPtr panjoint, tiltjoint;
    private: common::PID panpid, tiltpid;

    ///////////////////////////////////////////////////////////////////
    //Ros elements
    private: std::unique_ptr<ros::NodeHandle> rosNode;
    private: ros::Subscriber rosSub;
    private: ros::Publisher rosPub;
    private: ros::CallbackQueue rosQueue;
    private: std::thread rosQueueThread;
    private: event::ConnectionPtr updateConnection;


    //Handle the commands from the outside
    public: void handleCamCtrl(const boost::shared_ptr<const delbono_kobra::Ptz> &msg)
    {
      delbono_kobra::Ptz cmd = *msg;

      //Debug info
      //printf("Message received!\n");

      // Set the joint's target position.
      this->model->GetJointController()->SetPositionTarget(
          this->panjoint->GetScopedName(), cmd.p);
      this->model->GetJointController()->SetPositionTarget(
          this->tiltjoint->GetScopedName(), cmd.t);
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
      printf("%s\n", ("Camera Controller loaded on " + this->model->GetName()).c_str());

      ////////////////////////////////////////////////////////////////////
      //INITIALIZE GAZEBO ELEMENTS AND PIDS
      this->panjoint = this->model->GetJoints()[4];
      this->tiltjoint = this->model->GetJoints()[5];

      // Setup P-controllers, with a gain of 0.1.
      this->panpid = common::PID(0.001, 0.001, 1.0);
      this->tiltpid = common::PID(0.001, 0.001, 0.5);


      // Apply the P-controllers to the joints.
      this->model->GetJointController()->SetPositionPID(
      this->panjoint->GetScopedName(), this->panpid);
      this->model->GetJointController()->SetPositionPID(
      this->tiltjoint->GetScopedName(), this->tiltpid);

      /////////////////////////////////////////////////////////////////////
      //ROS OPERATIONS

      // Initialize ros, if it has not already been initialized
      if (!ros::isInitialized()){
        int argc = 0;
        char ** argv = NULL;
        ros::init(argc, argv, "gazebo_camera_ctrl", ros::init_options::NoSigintHandler);
      }
      // Create the ROS node
      rosNode.reset(new ros::NodeHandle("gazebo_camera_ctrl"));


      //////////////////////////////////////////////////////////////////
      //INITIALIZE SUBSCRIBER

      // Subscribe to /DelbonoKobra/ptz topic
      ros::SubscribeOptions so = ros::SubscribeOptions::create<delbono_kobra::Ptz>(
            "/" + this->model->GetName() + "/ptz", 10,
            boost::bind(&CameraController::handleCamCtrl, this, _1),
            ros::VoidPtr(), &this->rosQueue);

      this->rosSub = this->rosNode->subscribe(so);

      // Spin up the queue helper thread.
      this->rosQueueThread =
      std::thread(std::bind(&CameraController::QueueThread, this));


      ////////////////////////////////////////////////////////////////////
      //INITIALIZE PUBLISHER

      //Create the camera orientation topic
      this->rosPub = this->rosNode->advertise<nav_msgs::Odometry>(
          "/" + this->model->GetName() + "/camera_orientation", 50);

      // Listen to the update event.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          boost::bind(&CameraController::OnUpdate, this, _1));




    }

    // Called by the world update start event
    public: void OnUpdate(const common::UpdateInfo & /*_info*/)
    {
      ros::spinOnce();

       nav_msgs::Odometry odom;
       odom.header.stamp = ros::Time::now();
       odom.header.frame_id = "camera_pose";

       odom.pose.pose.position.x = 0.1;
       odom.pose.pose.position.y = 0;
       odom.pose.pose.position.z = 0.8125;

       geometry_msgs::Quaternion odom_quat =
          tf::createQuaternionMsgFromRollPitchYaw(0,
                            tiltjoint->GetAngle(0).Radian(),
                            panjoint->GetAngle(0).Radian());
       odom.pose.pose.orientation = odom_quat;


      //Publish the message
      this->rosPub.publish(odom);
    }

  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(CameraController)
}
