.ONESHELL:
.PHONY: test deps build clean astyle cmds docker

# Temporary directory to put files into.
TMP_DIR=/home/debix/rover-setup/gocv/

# Build shared or static library
BUILD_SHARED_LIBS?=ON

# OpenCV version to use.
OPENCV_VERSION?=4.8.1


# Package list for each well-known Linux distribution
RPMS=cmake curl wget git gtk2-devel libpng-devel libjpeg-devel libtiff-devel tbb tbb-devel libdc1394-devel unzip gcc-c++
DEBS=python3-pip unzip wget build-essential cmake curl git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
DEBS_UBUNTU_JAMMY=python3-pip unzip wget build-essential cmake curl git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-dev
JETSON=build-essential cmake git unzip pkg-config libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev libcanberra-gtk* libxvidcore-dev libx264-dev libgtk-3-dev libtbb2 libtbb-dev libdc1394-22-dev libv4l-dev v4l-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavresample-dev libvorbis-dev libxine2-dev libfaac-dev libmp3lame-dev libtheora-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenblas-dev libatlas-base-dev libblas-dev liblapack-dev libeigen3-dev gfortran libhdf5-dev protobuf-compiler libprotobuf-dev libgoogle-glog-dev libgflags-dev

# Detect Linux distribution
distro_deps=
ifneq ($(shell which dnf 2>/dev/null),)
	distro_deps=deps_fedora
else
ifneq ($(shell which apt-get 2>/dev/null),)
ifneq ($(shell cat /etc/os-release 2>/dev/null | grep "Jammy Jellyfish"),)
	distro_deps=deps_ubuntu_jammy
else
	distro_deps=deps_debian
endif
else
ifneq ($(shell which yum 2>/dev/null),)
	distro_deps=deps_rh_centos
endif
endif
endif

# Install all necessary dependencies.
deps: $(distro_deps)

deps_rh_centos:
	sudo yum -y install pkgconfig $(RPMS)

deps_fedora:
	sudo dnf -y install pkgconf-pkg-config $(RPMS)

deps_debian:
	sudo apt-get -y update
	sudo apt-get -y install $(DEBS)

deps_ubuntu_jammy:
	sudo apt-get -y update
	sudo apt-get -y install $(DEBS_UBUNTU_JAMMY)

deps_jetson:
	sudo sh -c "echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/nvidia-tegra.conf"
	sudo ldconfig
	sudo apt-get -y update
	sudo apt-get -y install $(JETSON)




# Cleanup old library files.
sudo_pre_install_clean:
ifneq (,$(wildcard /usr/local/lib/libopencv*))
	sudo rm -rf /usr/local/lib/cmake/opencv4/
	sudo rm -rf /usr/local/lib/libopencv*
	sudo rm -rf /usr/local/lib/pkgconfig/opencv*
	sudo rm -rf /usr/local/include/opencv*
else
ifneq (,$(wildcard /usr/local/lib64/libopencv*))
	sudo rm -rf /usr/local/lib64/cmake/opencv4/
	sudo rm -rf /usr/local/lib64/libopencv*
	sudo rm -rf /usr/local/lib64/pkgconfig/opencv*
	sudo rm -rf /usr/local/include/opencv*
else
ifneq (,$(wildcard /usr/local/lib/aarch64-linux-gnu/libopencv*))
	sudo rm -rf /usr/local/lib/aarch64-linux-gnu/cmake/opencv4/
	sudo rm -rf /usr/local/lib/aarch64-linux-gnu/libopencv*
	sudo rm -rf /usr/local/lib/aarch64-linux-gnu/pkgconfig/opencv*
	sudo rm -rf /usr/local/include/opencv*
endif
endif
endif





# Install system wide.
sudo_install:
	cd $(TMP_DIR)opencv/opencv-$(OPENCV_VERSION)/build
	sudo $(MAKE) install
	sudo ldconfig
	cd -


# Build a minimal Go app to confirm gocv works.
verify:
	go run $(TMP_DIR)cmd/version/main.go



# # Download OpenCV source tarballs.
# download:
# 	rm -rf $(TMP_DIR)opencv
# 	mkdir -p $(TMP_DIR)opencv
# 	cd $(TMP_DIR)opencv
# 	curl -Lo opencv.zip https://github.com/opencv/opencv/archive/refs/tags/$(OPENCV_VERSION).zip
# 	unzip -q opencv.zip
# 	curl -Lo opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/refs/tags/$(OPENCV_VERSION).zip
# 	unzip -q opencv_contrib.zip
# 	rm opencv.zip opencv_contrib.zip
# 	cd -

# # Build OpenCV.
# build:
# 	cd $(TMP_DIR)opencv/opencv-$(OPENCV_VERSION)
# 	mkdir build
# 	cd build
# 	rm -rf *
# 	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -D OPENCV_EXTRA_MODULES_PATH=$(TMP_DIR)opencv/opencv_contrib-$(OPENCV_VERSION)/modules -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=ON -D BUILD_opencv_java=NO -D BUILD_opencv_python=NO -D BUILD_opencv_python2=NO -D BUILD_opencv_python3=NO -D WITH_JASPER=OFF -D WITH_TBB=ON -DOPENCV_GENERATE_PKGCONFIG=ON ..
# 	$(MAKE) -j $(shell nproc --all --ignore 1)
# 	$(MAKE) preinstall
# 	cd -



# gocv-build-only: deps download sudo_pre_install_clean build

install-only: deps sudo_pre_install_clean sudo_install verify



























