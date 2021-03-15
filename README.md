# Modified Qt5 for WebAssembly Docker Image

This Dockerfile creates environment for building WebAssembly applications using Qt5 framework.

Used Qt5 framework version is not an official release - it is a modified version to fix several bugs in WebAssembly implementation.
You can see changes here: https://github.com/kusharami/qtbase/tree/ku_wip/webassembly2

## Usage

- Create a build directory (e.g. */path_to_output_build_dir*)
- Provide path to your project source code (e.g. */path_to_your_source_code*)
- Start building
```
docker run \
  --rm \
  -v /path_to_your_source_code:/src \
  -v /path_to_output_build_dir:/build \
  -u $(id -u):$(id -g) \
  kusharami/qt5-wasm-dev:latest \
  sh -c "qmake /src/your_project_file.pro && make"
```
- Then in build directory you will see output binaries.
