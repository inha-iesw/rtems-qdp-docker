#!/bin/bash

apt-get update
if [ ! -d '/opt/rtems-6-sparc-gr740-smp-5' ]; then
  tar xf rtems-6-sparc-gr740-smp-5.tar.xz
  cd rtems-6-sparc-gr740-smp-5
else
  echo "QDP already exists!"
fi

echo "RTEMS 6 SPARC GR740 SMP 5 setup complete."
