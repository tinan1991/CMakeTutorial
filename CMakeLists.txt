cmake_minimum_required(VERSION 3.15)
set(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS TRUE)
# cmake include setting
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
include(cmake/CustomMacro.cmake)
include(cmake/test_cmake.cmake)
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

# install(TARGETS ${PROJECT_NAME} CONFIGURATIONS Release DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE})
# install(FILES ${PROJECT_SOURCE_DIR}/TutorialConfig.h CONFIGURATIONS Release DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE})

# install(TARGETS ${PROJECT_NAME} CONFIGURATIONS Debug DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG})
# install(FILES ${PROJECT_SOURCE_DIR}/TutorialConfig.h CONFIGURATIONS Debug DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG})

#add CTest
include(CTest)
# does the application run
add_test (TutorialRuns Tutorial 25)
# does it sqrt of 25
add_test(TutorialComp25 Tutorial 25)
set_tests_properties(TutorialComp25 PROPERTIES PASS_REGULAR_EXPRESSION "25 is 5")
# does it handle negative numbers
add_test (TutorialNegative Tutorial -25)
set_tests_properties (TutorialNegative PROPERTIES PASS_REGULAR_EXPRESSION "-25 is 0")
# does it handle small numbers
add_test (TutorialSmall Tutorial 0.0001)
set_tests_properties (TutorialSmall PROPERTIES PASS_REGULAR_EXPRESSION "0.0001 is 0.01")
# does the usage message work?
add_test (TutorialUsage Tutorial)
set_tests_properties (TutorialUsage PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number")

#define a macro to simplify adding tests, then use it
macro (do_test arg result)
  add_test (TutorialComp${arg} Tutorial ${arg})
  set_tests_properties (TutorialComp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

do_test(25 "25 is 5")
do_test(225 "225 is 15")

# build a CPack driven installer package
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE  
     "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${TUTORIAL_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${TUTORIAL_VERSION_MINOR}")
include (CPack)
