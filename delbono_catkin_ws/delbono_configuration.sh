#!/bin/bash

path=`pwd`
echo $path

# Source ros script
source /opt/ros/kinetic/setup.bash


# Setup gazebo plugin path
cd $path/src/delbono_kobra/plugins/build
export GAZEBO_PLUGIN_PATH=`pwd`:$GAZEBO_PLUGIN_PATH

# Setup gazebo models path
cd $path/src/delbono_kobra/models
export GAZEBO_MODEL_PATH=`pwd`:$GAZEBO_MODEL_PATH


# Setup ros-package path
cd $path/devel/include
export ROS_PACKAGE_PATH=`pwd`:$ROS_PACKAGE_PATH

# Setun ros messages path
cd $path/install/include/
export std_msgs_INCLUDE_DIRS=`pwd`:$std_msgs_INCLUDE_DIRS


# Compile gazebo plugins
cd $path/src/delbono_kobra/plugins/build
cmake ../
make

# Compile ros-nodes using catkin
cd $path
catkin_make

source $path/devel/setup.bash


cd $path
