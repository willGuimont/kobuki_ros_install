#!/usr/bin/env bash
# Install Melodic ROS
pip install empy
pip3 install empy
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
sudo apt -y install ros-melodic-desktop # or sudo apt -y install ros-melodic-desktop-full
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt -y install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
sudo -H pip3 install rosdep rospkg rosinstall_generator rosinstall wstool vcstools catkin_tools catkin_pkg
sudo apt -y install libcanberra-gtk-module libcanberra-gtk3-module
sudo usermod -a -G dialout $USER
sudo apt -y install python-catkin-tools python3-dev python3-numpy
sudo rosdep init
rosdep update

# Install Kobuki stuff
sudo apt -y install ros-melodic-kobuki-*
sudo apt -y install ros-melodic-yocs-*

# Install OpenCV 3.2
sudo apt-get install build-essential
cd ~
sudo apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
curl https://codeload.github.com/opencv/opencv/zip/3.2.0 --output opencv.zip
unzip opencv.zip
cd opencv-3.2.0/
mkdir build
cd build
cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local  ..
make -j4 # can be changed to use more cores
sudo make install
cd ~
rm opencv.zip

# Catkin workspace
cd ~
mkdir -p catkin_ws/src
cd catkin_ws/
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
curl -sLf https://raw.githubusercontent.com/gaunthan/Turtlebot2-On-Melodic/master/install_basic.sh | bash
sudo apt -y install ros-melodic-vision-opencv ros-melodic-cv-bridge ros-melodic-image-geometry ros-melodic-depth-image-proc
sudo apt -y install ros-melodic-freenect-* ros-melodic-depthimage-to-laserscan
sudo apt -y install ros-melodic-openni*
sudo apt -y install ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control

catkin config -DPYTHON_EXECUTABLE=/usr/bin/python3 -DINCLUDE_DPYTHON_DIR=/usr/include/python3.6m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so

cd src
git clone -b melodic https://github.com/ros-perception/vision_opencv.git
cd ..

catkin_make
source devel/setup.bash

# Setup udev rules
rosrun kobuki_ftdi create_udev_rules

# To test run the following commands in two different terminals

# In terminal #1
# source devel/setup.bash
# roslaunch kobuki_node minimal.launch --screen

# In terminal #2
# source devel/setup.bash
# roslaunch kobuki_keyop safe_keyop.launch --screen

# Now you should be able to control the kobuki using the arrow keys

# Kinect: http://wiki.ros.org/openni_launch/Tutorials/QuickStart
