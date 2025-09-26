#!/bin/bash

apt-get update

if [ ! -d '/opt/src/rsb' ]; then
  # rm -rf /opt/src/rtems-source-builder-6.1 2> /dev/null
  rm -rf /opt/src/rsb 2> /dev/null
  echo "Downloading RTEMS source builder 6.1 ..."
  mkdir -p /opt/src
  cd /opt/src
  git clone https://gitlab.rtems.org/rtems/tools/rtems-source-builder.git rsb
  cd rsb
  git checkout 6.1
  echo "Build and install the tool suite..."
  cd rtems/
  ../source-builder/sb-set-builder --prefix=/opt/rtems/6 6/rtems-sparc
  echo "RTEMS source builder installed successfully!"
else
  echo "Source builder already exists!"
fi

export PATH=/opt/rtems/6/bin:$PATH
echo 'export PATH=/opt/rtems/6/bin:$PATH' >> ~/.bashrc

if [ ! -d '/opt/src/rtems-6.1' ]; then
  # rm -rf /opt/src/rtems-6.1 2> /dev/null
  echo "Downloading RTEMS kernel source 6 ..."
  cd /opt/src
  git clone https://gitlab.rtems.org/rtems/rtos/rtems.git
  cd rtems
  git checkout 6.1
  echo "Build the BSP..."
  cp /opt/config.ini /opt/src/rtems
  # ./waf configure --prefix=/opt/rtems/6 --enable-rtemsbsp=sparc/leon3
  ./waf configure --rtems-bsps=sparc/gr740 --rtems-tools=/opt/rtems/6 --prefix=/opt/rtems/6 --rtems-config=config.ini
  ./waf && ./waf install
  echo "RTEMS BSP built and installed successfully!"
else
  echo "RTEMS Kernel source already exists!"
fi

echo "Container is ready for RTEMS development!"