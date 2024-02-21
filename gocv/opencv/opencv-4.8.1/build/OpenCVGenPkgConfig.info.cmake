
set(BUILD_SHARED_LIBS "ON")

set(CMAKE_BINARY_DIR "/tmp/opencv/opencv-4.8.1/build")

set(CMAKE_INSTALL_PREFIX "/usr/local")

set(OpenCV_SOURCE_DIR "/tmp/opencv/opencv-4.8.1")

set(OPENCV_PC_FILE_NAME "opencv4.pc")

set(OPENCV_VERSION_PLAIN "4.8.1")

set(OPENCV_LIB_INSTALL_PATH "lib")

set(OPENCV_INCLUDE_INSTALL_PATH "include/opencv4")

set(OPENCV_3P_LIB_INSTALL_PATH "lib/opencv4/3rdparty")

set(_modules "opencv_gapi;opencv_stitching;opencv_aruco;opencv_bgsegm;opencv_bioinspired;opencv_ccalib;opencv_dnn_objdetect;opencv_dnn_superres;opencv_dpm;opencv_face;opencv_freetype;opencv_fuzzy;opencv_hfs;opencv_img_hash;opencv_intensity_transform;opencv_line_descriptor;opencv_mcc;opencv_quality;opencv_rapid;opencv_reg;opencv_rgbd;opencv_saliency;opencv_stereo;opencv_structured_light;opencv_phase_unwrapping;opencv_superres;opencv_optflow;opencv_surface_matching;opencv_tracking;opencv_highgui;opencv_datasets;opencv_text;opencv_plot;opencv_videostab;opencv_videoio;opencv_wechat_qrcode;opencv_xfeatures2d;opencv_shape;opencv_ml;opencv_ximgproc;opencv_video;opencv_xobjdetect;opencv_objdetect;opencv_calib3d;opencv_imgcodecs;opencv_features2d;opencv_dnn;opencv_flann;opencv_xphoto;opencv_photo;opencv_imgproc;opencv_core")

set(_extra "dl;m;pthread;rt")

set(_3rdparty "")

set(TARGET_LOCATION_opencv_gapi "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_gapi.so.4.8.1")

set(TARGET_LOCATION_opencv_stitching "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_stitching.so.4.8.1")

set(TARGET_LOCATION_opencv_aruco "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_aruco.so.4.8.1")

set(TARGET_LOCATION_opencv_bgsegm "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_bgsegm.so.4.8.1")

set(TARGET_LOCATION_opencv_bioinspired "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_bioinspired.so.4.8.1")

set(TARGET_LOCATION_opencv_ccalib "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_ccalib.so.4.8.1")

set(TARGET_LOCATION_opencv_dnn_objdetect "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_dnn_objdetect.so.4.8.1")

set(TARGET_LOCATION_opencv_dnn_superres "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_dnn_superres.so.4.8.1")

set(TARGET_LOCATION_opencv_dpm "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_dpm.so.4.8.1")

set(TARGET_LOCATION_opencv_face "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_face.so.4.8.1")

set(TARGET_LOCATION_opencv_freetype "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_freetype.so.4.8.1")

set(TARGET_LOCATION_opencv_fuzzy "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_fuzzy.so.4.8.1")

set(TARGET_LOCATION_opencv_hfs "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_hfs.so.4.8.1")

set(TARGET_LOCATION_opencv_img_hash "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_img_hash.so.4.8.1")

set(TARGET_LOCATION_opencv_intensity_transform "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_intensity_transform.so.4.8.1")

set(TARGET_LOCATION_opencv_line_descriptor "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_line_descriptor.so.4.8.1")

set(TARGET_LOCATION_opencv_mcc "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_mcc.so.4.8.1")

set(TARGET_LOCATION_opencv_quality "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_quality.so.4.8.1")

set(TARGET_LOCATION_opencv_rapid "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_rapid.so.4.8.1")

set(TARGET_LOCATION_opencv_reg "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_reg.so.4.8.1")

set(TARGET_LOCATION_opencv_rgbd "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_rgbd.so.4.8.1")

set(TARGET_LOCATION_opencv_saliency "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_saliency.so.4.8.1")

set(TARGET_LOCATION_opencv_stereo "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_stereo.so.4.8.1")

set(TARGET_LOCATION_opencv_structured_light "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_structured_light.so.4.8.1")

set(TARGET_LOCATION_opencv_phase_unwrapping "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_phase_unwrapping.so.4.8.1")

set(TARGET_LOCATION_opencv_superres "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_superres.so.4.8.1")

set(TARGET_LOCATION_opencv_optflow "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_optflow.so.4.8.1")

set(TARGET_LOCATION_opencv_surface_matching "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_surface_matching.so.4.8.1")

set(TARGET_LOCATION_opencv_tracking "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_tracking.so.4.8.1")

set(TARGET_LOCATION_opencv_highgui "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_highgui.so.4.8.1")

set(TARGET_LOCATION_opencv_datasets "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_datasets.so.4.8.1")

set(TARGET_LOCATION_opencv_text "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_text.so.4.8.1")

set(TARGET_LOCATION_opencv_plot "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_plot.so.4.8.1")

set(TARGET_LOCATION_opencv_videostab "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_videostab.so.4.8.1")

set(TARGET_LOCATION_opencv_videoio "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_videoio.so.4.8.1")

set(TARGET_LOCATION_opencv_wechat_qrcode "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_wechat_qrcode.so.4.8.1")

set(TARGET_LOCATION_opencv_xfeatures2d "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_xfeatures2d.so.4.8.1")

set(TARGET_LOCATION_opencv_shape "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_shape.so.4.8.1")

set(TARGET_LOCATION_opencv_ml "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_ml.so.4.8.1")

set(TARGET_LOCATION_opencv_ximgproc "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_ximgproc.so.4.8.1")

set(TARGET_LOCATION_opencv_video "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_video.so.4.8.1")

set(TARGET_LOCATION_opencv_xobjdetect "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_xobjdetect.so.4.8.1")

set(TARGET_LOCATION_opencv_objdetect "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_objdetect.so.4.8.1")

set(TARGET_LOCATION_opencv_calib3d "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_calib3d.so.4.8.1")

set(TARGET_LOCATION_opencv_imgcodecs "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_imgcodecs.so.4.8.1")

set(TARGET_LOCATION_opencv_features2d "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_features2d.so.4.8.1")

set(TARGET_LOCATION_opencv_dnn "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_dnn.so.4.8.1")

set(TARGET_LOCATION_opencv_flann "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_flann.so.4.8.1")

set(TARGET_LOCATION_opencv_xphoto "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_xphoto.so.4.8.1")

set(TARGET_LOCATION_opencv_photo "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_photo.so.4.8.1")

set(TARGET_LOCATION_opencv_imgproc "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_imgproc.so.4.8.1")

set(TARGET_LOCATION_opencv_core "/tmp/opencv/opencv-4.8.1/build/lib/libopencv_core.so.4.8.1")
