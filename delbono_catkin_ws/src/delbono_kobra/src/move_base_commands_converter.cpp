/*
* Convert from topic cmd_vel to /DelbonoKobra/cmd_velocity
*
* Code taken from:
* http://gazebosim.org/tutorials?tut=guided_i6
* http://gazebosim.org/tutorials?tut=guided_i5
*
* Changes done by Alex Delbono
*
*/


#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include "geometry_msgs/Twist.h"
#include <nav_msgs/Odometry.h>
#include <stdio.h>
#include <delbono_kobra/Ptz.h>

const double extraTime = 0.1;
ros::Publisher * velPubPtr = NULL;
ros::Publisher * camPubPtr = NULL;

void callback(const geometry_msgs::TwistConstPtr& msg){
  velPubPtr->publish(msg);

  delbono_kobra::Ptz camMsg;

  camMsg.p = 0;
  camMsg.t = 0;
  camMsg.z = 0;

  camPubPtr->publish(camMsg);
}

int main(int argc, char** argv){
  ros::init(argc, argv, "simulator_tf_broadcaster");

  ros::NodeHandle node;
  ros::Subscriber subSim = node.subscribe<geometry_msgs::Twist>("cmd_vel", 10, &callback);

  ros::Publisher velPub = node.advertise<geometry_msgs::Twist>("/DelbonoKobra/cmd_velocity", 100);
  velPubPtr = & velPub;

  ros::Publisher camPub = node.advertise<delbono_kobra::Ptz>("/DelbonoKobra/ptz", 100);
  camPubPtr = & camPub;

  ros::spin();
  return 0;
};
