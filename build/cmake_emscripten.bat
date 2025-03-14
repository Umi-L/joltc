@echo off
mkdir emscripten
cd emscripten
emcmake cmake ../../
echo Open emscripten and run `cmake --build .` to build the project.