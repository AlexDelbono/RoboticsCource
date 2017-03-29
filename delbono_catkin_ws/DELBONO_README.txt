*************************************
*************************************
*                                   *
*         ROBOTICS PROJECT          *
*                                   *
*************************************
*************************************
*
*  Author: Delbono Alex
*  Matricola: 850114
*  Codice Persona: 10433903
*  E-mail: alex.delbono@mail.polimi.it
*
*

The code has been developped under Ubuntu 16.04 and it has been tested 
on two other different physical machines running the same operative system. 


***************************************************************************
///////////////////////////////////////////////////////////////////////////


DESCRIPTION OF THE FILES PROVIDED
~/delbono_catkin_ws/delbono_configuration.sh
Script that installs all the ros nodes and the plugins. It also sets
all the environment variables.

~/delbono_catkin_ws/willowgarage_world_mapping.launch
Ros launch file for the mapping part

~/delbono_catkin_ws/willowgarage_world_autonomous.launch
Ros launch file for the autonomous navigation part

~/delbono_catkin_ws/src/delbono_kobra/maps/*
Configuration files of amcl and move-base. It also includes the map
built using gmapping.

~/delbono_catkin_ws/src/delbono_kobra/models/*
Include the DelbonoKobra model of the robot and the modified
Hokuyo sensor model

~/delbono_catkin_ws/src/delbono_kobra/msg/Ptz.msg
Is the definition of the custom message used to control pan
and tilt of the robot camera.

~/delbono_catkin_ws/src/delbono_kobra/plugins/diff_drive_plugin.cc
It is the plugin that controls the robot reading the cmd_velocity 
topic and converting the linear and angular velocity to whell 
velocities.
It also provides the integration measurments using
one of the three methods specified in the instructions.

~/delbono_catkin_ws/src/delbono_kobra/plugins/pan_tilt_camera_plugin.cc
It provides the position of the joints of the camera in the
/DelbonoKobra/camera_orientation topic, and controls the joints
using the messages from /DelbonoKobra/ptz topic.

~/delbono_catkin_ws/src/delbono_kobra/src/actionlib_planner.cpp
It provides the 8 destinations to the move_base actionlib server

~/delbono_catkin_ws/src/delbono_kobra/src/move_base_commands_converter.cpp
It converts the command sent by move_base and makes the camera rotate
with the body of the robot.

~/delbono_catkin_ws/src/delbono_kobra/teleop_joy.cpp
Converts the commands from the joystick to velcity commands.

~/delbono_catkin_ws/src/delbono_kobra/src/tf_camera_transfors.cpp
It publishes the tf transforms of the joints of the camera

~/delbono_catkin_ws/src/delbono_kobra/src/tf_pose_publisher.cpp
It publishes the transforms of the base of the robot and all its 
components


***************************************************************************
///////////////////////////////////////////////////////////////////////////


INSTALL THE SOFTWARE NEEDED:

1) ROS - kinetic (desktop-full)

Guide: http://wiki.ros.org/kinetic/Installation/Ubuntu

2) Additional packages not included in the ros installation:

sudo apt-get install ros-kinetic-slam-gmapping
sudo apt-get install ros-kinetic-map-server
sudo apt-get install ros-kinetic-amcl
sudo apt-get install ros-kinetic-move-base
sudo apt-get install ros-kinetic-joy

3) For unknown reason, some old files of some libraries
are incompatible with gazebo-7 because they try to include files that now
are in other folders. The best and fastest solution that I found is to copy some folders
in the /usr/include folder. After this, they can easily be removed using rm -r.

sudo cp -r /usr/include/gazebo-7/gazebo /usr/include/
sudo cp -r /usr/include/sdformat-4.0/sdf /usr/include/
sudo cp -r /usr/include/ignition/math2/ignition /usr/include/


4) In the next steps we will use the xbox 360 wireless controller
(I remeber Bardaro had got one, so I used it).
To setup the drivers and other things:
(first answer)

http://askubuntu.com/questions/165210/how-do-i-get-an-xbox-360-controller-working


***************************************************************************
///////////////////////////////////////////////////////////////////////////


EVALUATION OF THE PROJECT:

First of all copy the folder delbono_catkin_ws in your home directory.


******************

1) ROBOT STRUCTURE

Open the file: ~/delbono_catkin_ws/src/delbono_kobra/models/DelbonoKobra/model.sdf

It is possible to verify the size of the components and their shape.
In particular we can see at line 349 the camera. Attatched to it there is a plugin 
that publishes the images and the info.

At line 396 we have the Hokuyo sensor. As you can see I modified the Hokuyo sensor
in order to change the max and min angle of the rays and I called it myHokuyo.

At the end of the file I included the two plugins. One for the differential drive
and the other for the movement of the camera.

It is possible to see the robot in the next step.


*********************************

2) GAZEBO PLUGINS AND ROS SETUP

Open the file ~/delbono_catkin_ws/src/delbono_kobra/plugins/diff_drive_plugin.cc

from line 65 to line 84 it is possible to see the confersion from linear and angular 
velocity of the robot to wheels velocity and viceversa. 

form line 296 to line 373 it is possible to see the three integration methods that have to be implemented.

If you want you can see the plugin that controls the movement of
the joints of the camera opening this file:
~/delbono_catkin_ws/src/delbono_kobra/plugins/pan_tilt_camera_plugin.cc

Let's start the simulation in order to see the ros topics published.

open a terminal and type:

cd ~/delbono_catkin_ws

Now run the following script that compiles everything and sets all
the environment paths needed.

source delbono_configuration.sh

Open another shell, connect the joystick and run the drivers

sudo xboxdrv --silent

The location of your device will be printed, i.e. /dev/input/js0.
Open the file:

~/delbono_catkin_ws/willowgarage_world_mapping.launch

At line 24 set the device path previously seen.
Save and close.

Return to the shell with all the environment paths.
Launch the simulation typing:

roslaunch willowgarage_world_mapping.launch

(Sometimes the gazebo gui stops working and I do not know why, 
but you know... Type ctrl-c in the terminal and relaunch 
the previous command)

Now you probably see the robot and the willowgarage_world.

In another terminal type:

rostopic list

You can see all the topics published.
In particular:
- /DelbonoKobra/camera/camera_info
This is the info of the camera

- /DelbonoKobra/camera/image_raw
these are the images coming from the camera 

- /DelbonoKobra/camera_orientation
this is the orientation of the camera

- /DelbonoKobra/ptz
These are the commands sent to the joints of the camera
(Type "rostopic info DelbonoKobra/ptz" to see the custom type of the message)

- /DelbonoKobra/cmd_velocity
The control velocity of the robot is published in this topic
(linear and angular)

- /DelbonoKobra/odometry
In this topic there are the odometry measurements 
computed using one of the three integration methods


- /DelbonoKobra/simulator_odometry
In this topic there are the odometry measurements 
taken from the simulator

- /joy
These are the positions of the buttons and triggers of the joystick

- /scan
The scan from the Hokuyo laser

You can see the messages typing
rostopic echo [name of the topic]

In order to see the tf tree, in a new terminal type:
rosrun tf view_frames

and open the frames.pdf with "evince frame.pdf"


***************

3) ODOMETRY
Now open rviz typing:

rosrun rviz rviz

click Add and select TF.


You can see the differences between the exact odometry
of the simulator and the odometry computed using one 
of the three methods. 

If you move the robot with the joystick you can see that
the error between the two frames grows.
(RT and LT pan the camera, LB and RB tilt the camera)

You can change the integration method editing the line 3
of ~/delbono_catkin_ws/willowgarage_world_mapping.launch
(Restart needed)


Now in rviz click Add and select Map.
Set its topic to /map
You can see how the robot is building the map.

Close rviz and the simulation


**************

4) MAPPING
I have done the mapping only of a part of the environment.
My map can be found here:

~/delbono_catkin_ws/src/delbono_kobra/maps/DelbonoKobraMap.pgm

Now I was not able to set in a perfect way the parameters of move_base.
The robot has problems going through doors and also in the open environment
it goes near the goal and does a lot of stuff in order to align with it. 
Doing that takes some time, so I decided to prepair two launch files:
one that can be used to set the goal manually using rviz, and the other that 
performs the autonomous navigation with not so long distances, in order to
speed up the process.

first of all you can run the following command in the shell with the paths:
(The gazebo gui can still crash, relaunch all)

roslaunch willowgarage_world_manual.launch

After that you can run rviz in another terminal and set as fixed frame the map frame.
You can see the map adding a map subcribing to the topic /map.
Add also a PoseArray listening for the topic /particlecloud published by amcl.
Add a polygon that listens to the topic /move_base/loca_costmap/footprint
Add two paths. One subscribing to topic /move_base/TrajectoryPlannerROS/global_plan
and the other subscribing to topic /move_base/NavfnROS/plan.
add a Pose subscribing to /move_base/current_goal

Now in the Tool Properties set the 2D Nav Goal topic to /move_base_simple/goal

With the 2D Nav Goal button you can now set a goal and see that the robot tries
to reach it (even if it seems that sometimes it is blocked, after a while 
it reaches the point. It has more problems going through doors). 

Close all.

You can now launch the second launch file in the shell with the paths:
(The gazebo gui can still crash, relaunch all)

roslaunch willowgarage_world_autonomous.launch

This time, an actionlib client is implemented: it sends the goals to the robot.
You can again launch rviz with the previous configuration and see that the robot 
reaches all the destinations one by one. After it reaches the last one, it restarts
from the first.

The file with the destinations is located at:

~/delbono_catkin_ws/src/delbono_kobra/maps/destinations.txt

The eight destinations can be changed and also the location of the file can be 
changed modifying a parameter at line 5 of the willowgarage_world_autonomous.launch file.

That's all.



