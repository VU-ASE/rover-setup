# CMake generated Testfile for 
# Source directory: /tmp/opencv/opencv_contrib-4.8.1/modules/stereo
# Build directory: /tmp/opencv/opencv-4.8.1/build/modules/stereo
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(opencv_perf_stereo "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_stereo" "--gtest_output=xml:opencv_perf_stereo.xml")
set_tests_properties(opencv_perf_stereo PROPERTIES  LABELS "Extra;opencv_stereo;Performance" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/performance" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1274;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1134;ocv_add_perf_tests;/tmp/opencv/opencv_contrib-4.8.1/modules/stereo/CMakeLists.txt;2;ocv_define_module;/tmp/opencv/opencv_contrib-4.8.1/modules/stereo/CMakeLists.txt;0;")
add_test(opencv_sanity_stereo "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_stereo" "--gtest_output=xml:opencv_perf_stereo.xml" "--perf_min_samples=1" "--perf_force_samples=1" "--perf_verify_sanity")
set_tests_properties(opencv_sanity_stereo PROPERTIES  LABELS "Extra;opencv_stereo;Sanity" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/sanity" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1275;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1134;ocv_add_perf_tests;/tmp/opencv/opencv_contrib-4.8.1/modules/stereo/CMakeLists.txt;2;ocv_define_module;/tmp/opencv/opencv_contrib-4.8.1/modules/stereo/CMakeLists.txt;0;")
