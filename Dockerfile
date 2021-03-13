FROM emscripten/emsdk:1.39.4-upstream

COPY qt5 /qt5_source

WORKDIR /qt5_build

RUN apt-get -qq -y update \
	&& apt-get -y install \
		build-essential \
		perl \
		python \
	&& ../qt5_source/configure \
		-xplatform wasm-emscripten \
		-nomake examples -nomake tests \
		-confirm-license -opensource \
		-debug-and-release \
		-prefix /qt5-wasm-dev \
	&& make -j${nproc} \
	&& make install \
	&& apt-get -y clean
    && apt-get -y autoclean \
    && apt-get -y autoremove
	&& rm -rf /qt5_source \
	&& apt-get -qq -y update \
	&& apt-get -qq -y --no-install-recommends install \
		make \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN rm -rf /qt5_build

ENV PATH /qt5-wasm-dev:$PATH
