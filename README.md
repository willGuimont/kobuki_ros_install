# kobuki_ros_install
Install Kobuki node on ROS Melodic

# Notes
The script will install ROS Melodic, Kobuki related packages, OpenNI, OpenCV 3.2.0 from source, then create a catkin workspace at `~/catkin_ws` and create udev rules to use the Kobuki.

Requires `pip` and `pip3`

# Usage
```bash
chmod +x kobuki_ros_install.sh
sudo ./kobuki_ros_install.sh
```
