<!-- # OpenCV and GoCV installation

For GoCV, the pre-built shared object (so) and header (h) files are taken from the */usr/local/lib* and */usr/local/include* folder from a Debix that successfully installed openCV. To install it onto another debix. The folders are in tar files in the /prebuilt-deps folder of this repo.

To install, you just add the files in *usr-local-lib.tar.xz* (-> lib) and *usr-local-include.tar.xz* (->include) and append the contents of *lib* and *include* to the */usr/local/lib* and */usr/local/include* folders of the new debix.

## Dependencies

After copying, you might get linking errors when trying to build with GoCV. More specifically, you will need to install the following dependencies still:

```
sudo apt-get install libdc1394-dev \
					 libavcodec-dev \
					 libavformat-dev \
					 libavutil-dev \
					 libswscale-dev
``` -->
