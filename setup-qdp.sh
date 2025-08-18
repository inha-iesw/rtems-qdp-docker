#!/bin/bash

apt-get update
cd /opt
if [ ! -d '/opt/rtems-6-sparc-gr740-smp-5' ]; then
  if [ ! -f  'rtems-6-sparc-gr740-smp-5.tar.xz' ]; then
    wget https://rtems-qual.io.esa.int/public_release/QDPV5/rtems-6-sparc-gr740-smp-5.tar.xz
  fi
  pv rtems-6-sparc-gr740-smp-5.tar.xz | tar xJf -
  cd rtems-6-sparc-gr740-smp-5
else
  echo "QDP already exists!"
fi

echo "RTEMS 6 SPARC GR740 SMP 5 setup complete."
