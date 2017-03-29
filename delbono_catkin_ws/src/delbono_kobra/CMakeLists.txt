cmake_minimum_required(VERSION 2.8.3)
project(delbono_kobra)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

#set(CUSTOM_SDF_INCLUDE "/usr/include/sdformat-4.0")
#include_directories(${CUSTOM_SDF_INCLUDE})
#set(CUSTOM_GAZEBO_INCLUDE "/usr/include/gazebo-7")
#include_directories(${CUSTOM_GAZEBO_INCLUDE})
#set(CUSTOM_IGNITION_INCLUDE "/usr/include/ignition/math2")
#include_directories(${CUSTOM_IGNITION_INCLUDE})
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  move_base_msgs
  actionlib
  sensor_msgs
  gazebo_ros
  geometry_msgs
  nav_msgs
  roscpp
  std_msgs
  genmsg
  message_generation
  tf
)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend tag for "message_generation"
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependency has been pulled in
##     but can be declared for certainty nonetheless:
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

## Generate messages in the 'msg' folder
 add_message_files(
   FILES
   Ptz.msg
   OdomInfo.msg
)

## Generate services in the 'srv' folder
#add_service_files(
#   FILES
#   GetGoal.srv
#)

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
generate_messages(
   DEPENDENCIES
   std_msgs
   #geometry_msgs
)

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################

## To declare and build dynamic reconfigure parameters within this
## package, follow these steps:
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for "dynamic_reconfigure"
## * In this file (CMakeLists.txt):
##   * add "dynamic_reconfigure" to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * uncomment the "generate_dynamic_reconfigure_options" section below
##     and list every .cfg file to be processed

## Generate dynamic reconfigure parameters in the 'cfg' folder
# generate_dynamic_reconfigure_options(
#   cfg/DynReconf1.cfg
#   cfg/DynReconf2.cfg
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
 INCLUDE_DIRS include
#  LIBRARIES delbono_kobra
  CATKIN_DEPENDS message_runtime
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
  ${catkin_INCLUDE_DIRS}
)

#add_executable(pose_node src/pose_node.cpp)
#target_link_libraries(pose_node ${catkin_LIBRARIES})
#add_dependencies(pose_node delbono_kobra_gencpp)

#add_executable(control_node src/control_node.cpp)
#target_link_libraries(control_node ${catkin_LIBRARIES})
#add_dependencies(control_node delbono_kobra_gencpp)

#add_executable(sequencer_node src/sequencer_node.cpp)
#target_link_libraries(sequencer_node ${catkin_LIBRARIES})
#add_dependencies(sequencer_node delbono_kobra_gencpp)

#add_executable(send_plan src/send_plan.cpp)
#target_link_libraries(send_plan ${catkin_LIBRARIES})
#add_dependencies(send_plan delbono_kobra_gencpp)

## Declare a C++ library
# add_library(delbono_kobra
#   src/${PROJECT_NAME}/delbono_kobra.cpp
# )

## Add cmake target dependencies of the library
## as an example, code may need to be generated before libraries
## either from message generation or dynamic reconfigure
# add_dependencies(delbono_kobra ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Declare a C++ executable
add_executable(delbono_kobra_tf_broadcaster src/tf_pose_publisher.cpp)
add_dependencies(delbono_kobra_tf_broadcaster delbono_kobra_generate_messages_cpp)
target_link_libraries(delbono_kobra_tf_broadcaster ${catkin_LIBRARIES})

add_executable(move_base_commands_converter src/move_base_commands_converter.cpp)
add_dependencies(move_base_commands_converter delbono_kobra_generate_messages_cpp)
target_link_libraries(move_base_commands_converter ${catkin_LIBRARIES})

add_executable(actionlib_planner src/actionlib_planner.cpp)
add_dependencies(actionlib_planner delbono_kobra_generate_messages_cpp)
target_link_libraries(actionlib_planner ${catkin_LIBRARIES})

#add_executable(delbono_kobra_tf_broadcaster_static src/tf_static_transforms.cpp)
#target_link_libraries(delbono_kobra_tf_broadcaster_static ${catkin_LIBRARIES})

add_executable(delbono_kobra_tf_broadcaster_camera src/tf_camera_transforms.cpp)
add_dependencies(delbono_kobra_tf_broadcaster_camera delbono_kobra_generate_messages_cpp)
target_link_libraries(delbono_kobra_tf_broadcaster_camera ${catkin_LIBRARIES})

#add_executable(delbono_kobra_tf_odometry src/tf_odometry.cpp)
#target_link_libraries(delbono_kobra_tf_odometry ${catkin_LIBRARIES})

add_executable(teleop_joy src/teleop_joy.cpp)
add_dependencies(teleop_joy delbono_kobra_generate_messages_cpp)
target_link_libraries(teleop_joy ${catkin_LIBRARIES})

## Add cmake target dependencies of the executable
## same as for the library above
# add_dependencies(delbono_kobra_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Specify libraries to link a library or executable target against
# target_link_libraries(delbono_kobra_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS delbono_kobra delbono_kobra_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_delbono_kobra.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
