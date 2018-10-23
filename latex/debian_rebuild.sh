#!/bin/bash
# Rebuild texlive-latex-base on a ubuntu system so that LaTeX is compiled with afl instrumentation
PACKAGE=texlive-binaries

sudo apt-get build-dep ${PACKAGE}
sudo apt-get install build-essential fakeroot devscripts afl

#sudo update-alternatives --install /usr/bin/cc cc /usr/bin/afl-gcc 1 || exit 1
#sudo update-alternatives --set cc /usr/bin/afl-gcc || exit 1

export CC=/usr/bin/afl-gcc
export CXX=/usr/bin/afl-g++

BASEDIR=${PWD}

#mkdir ${BASEDIR}/debsrc
#cd ${BASEDIR}/debsrc
#apt-get source ${PACKAGE}



# Compile with the instrumenting compiler
cd ${BASEDIR}/debsrc/texlive-bin-*/
debuild --set-envvar=DH_VERBOSE=1 --set-envvar=CC=${CC} --set-envvar=CXX=${CXX} -us -uc -i -I 

# Install (only the package that contains the latex binary)
cd ${BASEDIR}/debsrc
sudo dpkg -i *.deb
sudo apt --fix-broken install

