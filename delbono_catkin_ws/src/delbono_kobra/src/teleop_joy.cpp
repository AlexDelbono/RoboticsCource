/*
* Teleop node that dirves the robot
*
* Code taken from:
* http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber(c%2B%2B)
* http://wiki.ros.org/joy/Tutorials/WritingTeleopNode
* https://www.clearpathrobotics.com/2014/09/ros-101-creating-node/
*
* Changes done by Alex Delbono
*
*/

#include <stdio.h>
#include <stdlib.h>
#include <thread>
#include "ros/ros.h"
#include "ros/callback_queue.h"
#include "ros/subscribe_options.h"
#include "geometry_msgs/Twist.h"
#include <boost/bind.hpp>
#include <sensor_msgs/Joy.h>
#include <delbono_kobra/Ptz.h>

#define LINEAR 1
#define ANGULAR 2
#define CAMERA_RIGHT 4
#define CAMERA_LEFT  5
#define CAMERA_UP 5
#define CAMERA_DOWN  4


#define MAX_LINEAR 0.25
#define MAX_ANGULAR 1.0
#define CAMERA_SCALE 0.15

#define THRESHOLD 0.2
#define CAMERA_THRESHOLD 0.8

ros::Publisher * velPubPtr = NULL;
ros::Publisher * camPosPubPtr = NULL;

float cameraPosition = 0, cameraTilt = 0;
bool flagR = false, flagL = false;
bool flagU = false, flagD = false;


void joyCallback (const sensor_msgs::Joy::ConstPtr& joy)
{
  geometry_msgs::Twist msg;

  float lin = joy->axes[LINEAR] > THRESHOLD || joy->axes[LINEAR] < -THRESHOLD
                ? joy->axes[LINEAR] : 0;
  float ang = joy->axes[ANGULAR] > THRESHOLD || joy->axes[ANGULAR] < -THRESHOLD
                ? joy->axes[ANGULAR] : 0;

  msg.linear.x = MAX_LINEAR * lin;
  msg.linear.y = 0;
  msg.linear.z = 0;
  msg.angular.x = 0;
  msg.angular.y = 0;
  msg.angular.z = MAX_ANGULAR * ang;

  velPubPtr->publish(msg);

  //Pan
  if(joy->axes[CAMERA_RIGHT]> CAMERA_THRESHOLD && !flagR) {
    flagR=true;
    cameraPosition-= CAMERA_SCALE * joy->axes[CAMERA_RIGHT];
  } else if(joy->axes[CAMERA_RIGHT]<= CAMERA_THRESHOLD && flagR) {
    flagR=false;
  }

  if(joy->axes[CAMERA_LEFT]> CAMERA_THRESHOLD && !flagL) {
    flagL=true;
    cameraPosition+= CAMERA_SCALE * joy->axes[CAMERA_LEFT];
  } else if(joy->axes[CAMERA_LEFT]<= CAMERA_THRESHOLD && flagL) {
    flagL=false;
  }

  //Tilt
  if(joy->buttons[CAMERA_UP] && !flagU) {
    flagU=true;
    cameraTilt-= CAMERA_SCALE;
  } else if(!joy->buttons[CAMERA_UP] && flagU) {
    flagU=false;
  }

  if(joy->buttons[CAMERA_DOWN] && !flagD) {
    flagD=true;
    cameraTilt+= CAMERA_SCALE;
  } else if(!joy->buttons[CAMERA_DOWN] && flagD) {
    flagD=false;
  }

  delbono_kobra::Ptz pos;

  pos.p = cameraPosition;
  pos.t = cameraTilt;
  pos.z = 0;

  camPosPubPtr->publish(pos);

  ros::spinOnce();
}


int main(int argc, char **argv)
{
  ros::init(argc, argv, "teleop_joy");

  ros::NodeHandle n;

  ros::Publisher velPub = n.advertise<geometry_msgs::Twist>("/DelbonoKobra/cmd_velocity", 100);
  velPubPtr = & velPub;

  ros::Publisher camPosPub = n.advertise<delbono_kobra::Ptz>("/DelbonoKobra/ptz", 100);
  camPosPubPtr = &camPosPub;

  ros::Subscriber joySub = n.subscribe<sensor_msgs::Joy>("/joy", 100, joyCallback);

  ros::spin();
}
