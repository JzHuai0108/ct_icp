
roslaunch ct_icp_odometry ct_icp_on_dataset.launch dataset:=KITTI_360 \
    dataset_path:=/media/jhuai/OneTouchBlss/jhuai/data/KITTI360/train sequence:=07 \
    config:=/home/jhuai/Documents/lidar/ct_icp_ws/src/ct_icp_odometry/params/ct_icp/ct_icp_driving.yaml \
    frequency:=30

for seq=00 ... 21
roslaunch ct_icp_odometry ct_icp_on_dataset.launch dataset:=KITTI \
    dataset_path:=/media/jhuai/OneTouchBlss/jhuai/data/KITTI \
    sequence:=00 \
    config:=/home/jhuai/Documents/lidar/ct_icp_ws/src/ct_icp_odometry/params/ct_icp/ct_icp_driving.yaml \
    frequency:=10

cd ~/Documents/lidar/ct_icp/cmake-build-release
cmake --build . --target install --config Release --parallel 12

cd ~/Documents/lidar/ct_icp/install/CT_ICP/bin
./run_odometry -c /home/jhuai/Documents/lidar/ct_icp/config/odometry/driving_config_kitti.yaml

# pylidar-SLAM, but it has many errors due to imcompatibility between pylidar-slam and ct_icp.
export KITTI_ODOM_ROOT=/media/jhuai/BackupPlus/jhuai/data/KITTI/semantic/dataset
python run.py dataset=kitti slam/odometry=ct_icp_robust_drive
