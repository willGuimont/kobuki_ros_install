# based on https://www.youtube.com/watch?v=edNsh7bHkhQ

# install ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-noetic-ros-base
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo apt install python3-rosdep
sudo rosdep init
rosdep update
sudo rosdep init

# install konuki stuff
mkdir kobuki_ws
cd kobuki_ws/
mkdir src
catkin_make
cd src
git clone https://github.com/yujinrobot/kobuki
git clone https://github.com/yujinrobot/yujin_ocs
cd yujin_ocs/
rm -rf yocs_ar_marker_tracking/ yocs_ar_pair_approach/ yocs_ar_pair_tracking/ yocs_diff_drive_pose_controller/ yocs_joyop/ yocs_keyop/ yocs_localization_manager/ yocs_math_toolkit/ yocs_navigator/ yocs_navi_toolkit/ yocs_rapps/ yocs_safety_controller/ yocs_virtual_sensor/ yocs_waypoint_provider/ yocs_waypoints_navi/ yujin_ocs/
cd ..
sudo apt install -y liborocos-kdl-dev
cd ..
rosdep install --from-paths src --ignore-src -r -y
catkin_make

# Test it
# in one terminal
# source devel/setup.bash
# roslaunch kobuki_node minimal.launch

# in another terminal
# source devel/setup.bash 
# roslaunch kobuki_keyop safe_keyop.launch --screen

# you should now be able to control the kobuki using the arrow keys on your keyboard
