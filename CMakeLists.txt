cmake_minimum_required(VERSION 3.15)
set(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS TRUE)
# cmake include setting
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

project(Tutorial VERSION 0.1.0)
include(cmake/cmake_config.cmake)

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

if (MSVC)
  set_target_properties(${target_name} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}")
  #set filter for VisualStudio 源码分组 只针对MSVC
  source_group(TREE ${PROJECT_SOURCE_DIR} FILES ${ALL_FILES})
  set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${target_name})
endif(MSVC)

# install
if(WIN32)
  set(dy_lib_postfix ".dll")
else()
  set(dy_lib_postfix ".so")
endif()

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC ${EXTRA_LIBS})
target_include_directories(${PROJECT_NAME} PUBLIC ${EXTRA_INCLUDES})

install(TARGETS ${PROJECT_NAME} CONFIGURATIONS Release DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE})
install(FILES ${PROJECT_SOURCE_DIR}/TutorialConfig.h CONFIGURATIONS Release DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE})

install(TARGETS ${PROJECT_NAME} CONFIGURATIONS Debug DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG})
install(FILES ${PROJECT_SOURCE_DIR}/TutorialConfig.h CONFIGURATIONS Debug DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG})

