@echo off
mkdir emscripten
cd emscripten
emcmake cmake ../../ -DCMAKE_BUILD_TYPE=Debug -DJPH_BUILD_SHARED=OFF -DUSE_WASM_SIMD=ON -DCROSS_PLATFORM_DETERMINISTIC=ON
echo Open emscripten and run `cmake --build .` to build the project.
