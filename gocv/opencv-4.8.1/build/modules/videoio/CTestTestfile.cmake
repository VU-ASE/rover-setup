# CMake generated Testfile for 
# Source directory: /tmp/opencv/opencv-4.8.1/modules/videoio
# Build directory: /tmp/opencv/opencv-4.8.1/build/modules/videoio
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(opencv_perf_videoio "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_videoio" "--gtest_output=xml:opencv_perf_videoio.xml")
set_tests_properties(opencv_perf_videoio PROPERTIES  LABELS "Main;opencv_videoio;Performance" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/performance" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1274;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/modules/videoio/CMakeLists.txt;272;ocv_add_perf_tests;/tmp/opencv/opencv-4.8.1/modules/videoio/CMakeLists.txt;0;")
add_test(opencv_sanity_videoio "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_videoio" "--gtest_output=xml:opencv_perf_videoio.xml" "--perf_min_samples=1" "--perf_force_samples=1" "--perf_verify_sanity")
set_tests_properties(opencv_sanity_videoio PROPERTIES  LABELS "Main;opencv_videoio;Sanity" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/sanity" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1275;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/modules/videoio/CMakeLists.txt;272;ocv_add_perf_tests;/tmp/opencv/opencv-4.8.1/modules/videoio/CMakeLists.txt;0;")
