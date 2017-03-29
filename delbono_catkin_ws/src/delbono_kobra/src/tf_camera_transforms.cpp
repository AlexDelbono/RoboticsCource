/*
* Publish camera transofrms
*
* Code taken from:
* http://wiki.ros.org/tf/Tutorials/Writing%20a%20tf%20broadcaster%20%28C%2B%2B%29
*
* Changes done by Alex Delbono
*
*/


#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>

void poseCallback(const nav_msgs::OdometryConstPtr& msg){
  static tf::TransformBroadcaster br;
  tf::Transform transform, panJointTransform, tiltJointTransform;
  transform.setOrigin( tf::Vector3(0.0,
                                   0.0,
                                   0.0) );
  panJointTransform.setOrigin( tf::Vector3(msg->pose.pose.position.x,
                                   msg->pose.pose.position.y,
                                   msg->pose.pose.position.z) );

  tiltJointTransform.setOrigin( tf::Vector3(0.0,
                                   0.0,
                                   0.0) );
  tf::Quaternion q, qPan, qTilt, temp;
  tf::quaternionMsgToTF(msg->pose.pose.orientation, q);
  tf::Matrix3x3 m(q);
  double roll, pitch, yaw;
  m.getRPY(roll, pitch, yaw);
  q.setRPY(roll, pitch, 0.0);
  qPan.setRPY(0.0, 0.0, 0.0);
  qTilt.setRPY(0.0, 0.0, tf::getYaw(msg->pose.pose.orientation));

  transform.setRotation(q);
  panJointTransform.setRotation(qPan);
  tiltJointTransform.setRotation(qTilt);

  br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "tilt_joint", "camera"));
  br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "simulator_tilt_joint", "simulator_camera"));
  br.sendTransform(tf::StampedTransform(panJointTransform, ros::Time::now(), "delbono_odometry", "pan_joint"));
  br.sendTransform(tf::StampedTransform(panJointTransform, ros::Time::now(), "simulator_odometry", "simulator_pan_joint"));
  br.sendTransform(tf::StampedTransform(tiltJointTransform, ros::Time::now(), "pan_joint", "tilt_joint"));
  br.sendTransform(tf::StampedTransform(tiltJointTransform, ros::Time::now(), "simulator_pan_joint", "simulator_tilt_joint"));

}

int main(int argc, char** argv){
  ros::init(argc, argv, "camera_tf_broadcaster");

  ros::NodeHandle node;
  ros::Subscriber sub = node.subscribe("DelbonoKobra/camera_orientation", 10, &poseCallback);

  ros::spin();
  return 0;
};
