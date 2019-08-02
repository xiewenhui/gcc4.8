#!/bin/bash

readonly WORK_ROOT="$(cd $(dirname $0) && pwd)"
readonly BuildOut="/home/xiewenhui/work/gcc-4.8-env"
mkdir -p  $BuildOut
echo  ${WORK_ROOT}

echo "building gmp..."
cd ${WORK_ROOT}
tar -zxvf gmp-5.1.3.tar.gz && cd gmp-5.1.3 
./configure --prefix=$BuildOut
make; make check; make install
echo "end build gmp"

echo "building mpfr..."
cd ${WORK_ROOT}
tar -zxvf mpfr-3.1.2.tar.gz && cd mpfr-3.1.2 
./configure --prefix=$BuildOut --with-gmp-include=$BuildOut/include --with-gmp-lib=$BuildOut/lib
make; make check; make install
echo "end build mpfr"

echo "building mpc..."
cd ${WORK_ROOT}
tar -zxvf mpc-1.0.1.tar.gz && cd mpc-1.0.1
./configure --prefix=$BuildOut --with-gmp-include=$BuildOut/include --with-gmp-lib=$BuildOut/lib --with-mpfr-include=$BuildOut/include --with-mpfr-lib=$BuildOut/lib 
make; make check; make install
echo "end build mpc"

echo "building gcc..."
cd ${WORK_ROOT}
tar -zxvf gcc-4.8.2.tar.gz  && cd gcc-4.8.2
export LD_LIBRARY_PATH=$BuildOut/lib:$LD_LIBRARY_PATH
./configure --prefix=$BuildOut --enable-threads=posix --disable-checking --disable-multilib --enable-languages=c,c++ --with-gmp=$BuildOut --with-mpfr=$BuildOut --with-mpc=$BuildOut
make;make install
echo "end build gcc"

echo "building autoconf..."
cd ${WORK_ROOT}
tar -zxf autoconf-2.69.tar.gz && cd autoconf-2.69
./configure --prefix=$BuildOut
make;make install
echo "end build autoconf"

echo "building automake..."
cd ${WORK_ROOT}
tar -zxf automake-1.15.tar.gz && cd automake-1.15
./configure --prefix=$BuildOut
make;make install
echo "end build automake"

echo "building binutils..."
cd ${WORK_ROOT}
tar -zxf binutils-2.25.1.tar.gz && cd binutils-2.25.1
./configure --prefix=$BuildOut
make;make install
echo "end build binutils"

echo "building pkg-config..."
cd ${WORK_ROOT}
tar -zxf pkg-config-0.27.1.tar.gz && cd pkg-config-0.27.1
./configure --prefix=$BuildOut --with-internal-glib
make;make install
echo "end build pkg-config"

echo "building libtool..."
cd ${WORK_ROOT}
tar -zxf  libtool-2.4.2.tar.gz  && cd libtool-2.4.2
./configure --prefix=$BuildOut
make;make install
echo "end build libtool"

echo "setting env variable..."
echo "# gcc4.8 env" >>  ~/.bash_profile
echo -n "export LD_LIBRARY_PATH=$BuildOut/lib64:$BuildOut/lib:"  >> ~/.bash_profile
echo '$LD_LIBRARY_PATH' >> ~/.bash_profile
echo -n "export PATH=$BuildOut/bin/:" >> ~/.bash_profile
echo '$PATH' >> ~/.bash_profile
source  ~/.bash_profile
echo "end set env variable"
