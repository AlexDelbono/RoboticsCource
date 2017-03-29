/*
* Actionlib client that goes through a list of destinations
*
* Code taken from:
* http://wiki.ros.org/navigation/Tutorials/SendingSimpleGoals
*
* Changes done by Alex Delbono
*
*/

#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include <stdio.h>
#include <vector>
#include <iostream>
#include <fstream>

#define DEST 8
#define VAL 3

typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;
std::string path;
double destinations[DEST][VAL];

void  readFile()
{
  std::ifstream myfile;
  std::string line;

  myfile.open (path);

  if (myfile.is_open())
  {
    int i, j;

    for(i=0; i<DEST; ++i)
    {
        getline (myfile,line);
        std::stringstream lineStream(line);
        double temp;
        for(j = 0; j<VAL; ++j)
        {
          lineStream >> temp;

          destinations[i][j] = temp;
        }
    }
    myfile.close();
  }

  else std::cerr << "Unable to open destinations file\n" << path << std::endl;

}

int main(int argc, char** argv){
  ros::init(argc, argv, "actionlib_planner");

  if(!ros::param::get("destinations_file", path))
  {
    std::cerr << "Ros param \"destinations_file\" is not set" << std::endl;
    exit(-1);
  }

  readFile();

  //tell the action client that we want to spin a thread by default
  MoveBaseClient ac("move_base", true);

  //wait for the action server to come up
  while(!ac.waitForServer(ros::Duration(5.0))){
    ROS_INFO("Waiting for the move_base action server to come up");
  }

  int index=0;
  while(ros::ok())
  {

    move_base_msgs::MoveBaseGoal goal;

    //we'll send a goal to the robot
    goal.target_pose.header.frame_id = "map";
    goal.target_pose.header.stamp = ros::Time::now();

    goal.target_pose.pose.position.x = destinations[index][0];
    goal.target_pose.pose.position.y = destinations[index][1];
    goal.target_pose.pose.orientation.w = destinations[index][2];

    ROS_INFO("Sending goal");
    ac.sendGoal(goal);

    ac.waitForResult();

    index = index < DEST-1 ? index+1 : 0;
  }

  return 0;
}
