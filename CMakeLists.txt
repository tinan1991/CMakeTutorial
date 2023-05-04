cmake_minimum_required(VERSION 3.0.0)
project(Tutorial VERSION 0.1.0)

set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 0)

configure_file("${PROJECT_SOURCE_DIR}/TutorialConfig.h.in" "${PROJECT_SOURCE_DIR}/TutorialConfig.h")

include(CTest)
enable_testing()

include_directories(${PROJECT_BINARY_DIR})
add_executable(Tutorial main.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)

