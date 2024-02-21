# CMake generated Testfile for 
# Source directory: /home/debix/ase-gocv/opencv/opencv-4.8.1/modules/core
# Build directory: /home/debix/ase-gocv/opencv/opencv-4.8.1/build/modules/core
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(opencv_perf_core "/home/debix/ase-gocv/opencv/opencv-4.8.1/build/bin/opencv_perf_core" "--gtest_output=xml:opencv_perf_core.xml")
set_tests_properties(opencv_perf_core PROPERTIES  LABELS "Main;opencv_core;Performance" WORKING_DIRECTORY "/home/debix/ase-gocv/opencv/opencv-4.8.1/build/test-reports/performance" _BACKTRACE_TRIPLES "/home/debix/ase-gocv/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/home/debix/ase-gocv/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1274;ocv_add_test_from_target;/home/debix/ase-gocv/opencv/opencv-4.8.1/modules/core/CMakeLists.txt;177;ocv_add_perf_tests;/home/debix/ase-gocv/opencv/opencv-4.8.1/modules/core/CMakeLists.txt;0;")
add_test(opencv_sanity_core "/home/debix/ase-gocv/opencv/opencv-4.8.1/build/bin/opencv_perf_core" "--gtest_output=xml:opencv_perf_core.xml" "--perf_min_samples=1" "--perf_force_samples=1" "--perf_verify_sanity")
set_tests_properties(opencv_sanity_core PROPERTIES  LABELS "Main;opencv_core;Sanity" WORKING_DIRECTORY "/home/debix/ase-gocv/opencv/opencv-4.8.1/build/test-reports/sanity" _BACKTRACE_TRIPLES "/home/debix/ase-gocv/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/home/debix/ase-gocv/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1275;ocv_add_test_from_target;/home/debix/ase-gocv/opencv/opencv-4.8.1/modules/core/CMakeLists.txt;177;ocv_add_perf_tests;/home/debix/ase-gocv/opencv/opencv-4.8.1/modules/core/CMakeLists.txt;0;")
