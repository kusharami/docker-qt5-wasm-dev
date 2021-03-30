# ---------------------------
# Build Qt from source
# ---------------------------
FROM emscripten/emsdk:1.39.4-upstream

COPY qt5 /qt5_source

WORKDIR /qt5_source

RUN unset CONFIG \
	&& ./configure \
		-xplatform wasm-emscripten \
		-nomake examples -nomake tests \
		-confirm-license -opensource \
		-release \
		-prefix /qt5-wasm-dev \
	&& make -j$(nproc) \
	&& make install

# ---------------------------
# Copy binaries to final image
# ---------------------------
FROM emscripten/emsdk:1.39.4-upstream

COPY --from=0 /qt5-wasm-dev /

ENV PATH /qt5-wasm-dev/bin:$PATH

VOLUME /build
WORKDIR /build

ENTRYPOINT ["/emsdk/entrypoint"]
CMD ["bash"]
