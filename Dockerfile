FROM emscripten/emsdk:1.39.4-upstream

COPY qt5 /qt5_source

WORKDIR /qt5_source

RUN apt-get -qq -y update \
	&& apt-get -y --no-install-recommends install \
		perl \
	&& unset CONFIG \
	&& ./configure \
		-xplatform wasm-emscripten \
		-nomake examples -nomake tests \
		-confirm-license -opensource \
		-release \
		-prefix /qt5-wasm-dev \
	&& make -j$(nproc) \
	&& make install \
	&& cd / \
	&& rm -rf /qt5_source \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /qt5-wasm-dev/bin:$PATH

VOLUME /build
WORKDIR /build

ENTRYPOINT ["/emsdk/entrypoint"]
CMD ["bash"]
