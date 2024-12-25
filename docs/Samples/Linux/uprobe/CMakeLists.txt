cmake_minimum_required(VERSION 3.2)

project(DynamicTelemetry_UProbe)

add_executable(app main.cpp)

add_compile_options(-fsanitize=address)
add_link_options(-fsanitize=address)

set_property(TARGET app PROPERTY CXX_STANDARD 20)
