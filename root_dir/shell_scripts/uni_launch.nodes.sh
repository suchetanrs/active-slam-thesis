#!/bin/bash

# Function to terminate all background processes and exit the script
function cleanup_and_exit {
    echo "Ctrl+C detected. Terminating all background processes..."
    kill $(jobs -p)
    exit 1
}

# Trap Ctrl+C signal and call the cleanup_and_exit function
trap cleanup_and_exit INT

# #Essential
ros2 launch scout_gazebo start_world.launch.py &
ros2 launch scout_gazebo rviz_launch.py &
ros2 run traversability_gridmap multi_traversability_thresholded --ros-args --params-file /root/dev_ws/src/traversability_packages/traversability_packages/traversability_gridmap/params/traversability_params.yaml &

sleep 10

export SCOUT_NAMESPACE="scout_2"
export SCOUT_X="1.0"
export SCOUT_Y="1.0"
mkdir /home/$SCOUT_NAMESPACE
ros2 launch scout_gazebo scout_simu.launch.py &

#ros2 launch scout_navigation2 scout_rtab_rgbd.launch.py &
ros2 launch traversability_gridmap traversability_launch.py &
ros2 launch scout_navigation2 navigation.launch.py &
#ros2 launch frontier_exploration exploration.launch.py &
wait