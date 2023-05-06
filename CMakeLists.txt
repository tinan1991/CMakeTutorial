cmake_minimum_required(VERSION 3.0.0)
project(Tutorial VERSION 0.1.0)

set(TUTORIAL_VERSION_MAJOR 1)
set(TUTORIAL_VERSION_MINOR 0)
set(TUTORIAL_VERSION_PATCH 0)
configure_file("${PROJECT_SOURCE_DIR}/TutorialConfig.h.in" "${PROJECT_SOURCE_DIR}/TutorialConfig.h")

option(USE_MYMATH "Use tutorial provided math implementation" ON)
if (USE_MYMATH) 
add_subdirectory(MathFunctions)
list(APPEND EXTRA_LIBS MathFunctions)
list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/MathFunctions)
endif(USE_MYMATH)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC ${EXTRA_LIBS})
target_include_directories(${PROJECT_NAME} PUBLIC ${EXTRA_INCLUDES})

