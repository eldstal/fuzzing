#!/bin/bash
# Rebuild texlive-latex-base on a ubuntu system so that LaTeX is compiled with afl instrumentation
PACKAGE=texlive-latex-base

sudo apt-get build-dep ${PACKAGE}
sudo apt-get install build-essential fakeroot devscripts afl


BASEDIR=${PWD}
mkdir src
cd src
apt-get source ${PACKAGE}
cd texlive-base-*/
patch -p0 < ${BASEDIR}/debian_afl.patch

# Compile
debuild -us -uc -i -I

# Install
sudo debi
sudp apt --fix-broken install
