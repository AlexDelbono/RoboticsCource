cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CUSTOM_MSGS "./../../../install/include")
include_directories(${CUSTOM_MSGS})

#find_package(roscpp REQUIRED)
#find_package(std_msgs REQUIRED)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  image_transport
  sensor_msgs
  tf
  tf2_ros
  gazebo_msgs
  gazebo_plugins
  gazebo_ros
)
include_directories(${GAZEBO_INCLUDE_DIRS})
link_directories(${GAZEBO_LIBRARY_DIRS})
include_directories(${roscpp_INCLUDE_DIRS})
include_directories(${std_msgs_INCLUDE_DIRS})


add_library(diff_drive_plugin SHARED diff_drive_plugin.cc)
target_link_libraries(diff_drive_plugin ${GAZEBO_LIBRARIES}  ${roscpp_LIBRARIES})

add_library(pan_tilt_camera_plugin SHARED pan_tilt_camera_plugin.cc)
target_link_libraries(pan_tilt_camera_plugin ${GAZEBO_LIBRARIES})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GAZEBO_CXX_FLAGS}")
