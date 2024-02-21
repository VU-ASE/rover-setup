# CMake generated Testfile for 
# Source directory: /tmp/opencv/opencv_contrib-4.8.1/modules/dnn_superres
# Build directory: /tmp/opencv/opencv-4.8.1/build/modules/dnn_superres
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(opencv_perf_dnn_superres "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_dnn_superres" "--gtest_output=xml:opencv_perf_dnn_superres.xml")
set_tests_properties(opencv_perf_dnn_superres PROPERTIES  LABELS "Extra;opencv_dnn_superres;Performance" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/performance" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1274;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1134;ocv_add_perf_tests;/tmp/opencv/opencv_contrib-4.8.1/modules/dnn_superres/CMakeLists.txt;3;ocv_define_module;/tmp/opencv/opencv_contrib-4.8.1/modules/dnn_superres/CMakeLists.txt;0;")
add_test(opencv_sanity_dnn_superres "/tmp/opencv/opencv-4.8.1/build/bin/opencv_perf_dnn_superres" "--gtest_output=xml:opencv_perf_dnn_superres.xml" "--perf_min_samples=1" "--perf_force_samples=1" "--perf_verify_sanity")
set_tests_properties(opencv_sanity_dnn_superres PROPERTIES  LABELS "Extra;opencv_dnn_superres;Sanity" WORKING_DIRECTORY "/tmp/opencv/opencv-4.8.1/build/test-reports/sanity" _BACKTRACE_TRIPLES "/tmp/opencv/opencv-4.8.1/cmake/OpenCVUtils.cmake;1763;add_test;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1275;ocv_add_test_from_target;/tmp/opencv/opencv-4.8.1/cmake/OpenCVModule.cmake;1134;ocv_add_perf_tests;/tmp/opencv/opencv_contrib-4.8.1/modules/dnn_superres/CMakeLists.txt;3;ocv_define_module;/tmp/opencv/opencv_contrib-4.8.1/modules/dnn_superres/CMakeLists.txt;0;")
