fuzz: pdflatex
	mkdir -p findings
	afl-fuzz -i inputs -o findings -- ./pdflatex @@


TEX_VER:=20180414
TEX_TARBALL=texlive-$(TEX_VER)-source.tar.xz
TEX_URL=ftp://tug.org/historic/systems/texlive/2018/$(TEX_TARBALL)


pdflatex:
	cp /usr/bin/pdflatex pdflatex

tex_build: texlive_src
	cd texlive_src && TL_CONFIGURE_ARGS="--without-x" CC=afl-gcc CXX=afl-g++ ./Build

$(TEX_TARBALL):
	wget $(TEX_URL) -O $@

texlive_src: $(TEX_TARBALL)
	mkdir $@
	tar -xf $< --strip-components=1 -C $@
