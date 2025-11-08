cmake_minimum_required(VERSION 3.15)
project(polyverse_cpp_engine VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(include)

# Source files
set(SOURCES
    src/engine.cpp
    src/rest_bridge.cpp
)

# Create executable
add_executable(cpp_engine ${SOURCES})

# Link libraries
# TODO: Add Eigen3 when available
# find_package(Eigen3 REQUIRED)
# target_link_libraries(cpp_engine Eigen3::Eigen)

# Compiler options
target_compile_options(cpp_engine PRIVATE -Wall -Wextra)

# Installation
install(TARGETS cpp_engine DESTINATION bin)

