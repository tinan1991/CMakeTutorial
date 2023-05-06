# use Unicode
add_definitions("-DUNICODE" "-D_UNICODE")
# c++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#build type
if(CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRINGS "Choose the build type, options: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()

#build option
#MESSAGE(STATUS "build option ${MSVC}")
message(STATUS "build option ${CMAKE_C_FLAGS} / ${CMAKE_CXX_FLAGS}")
if(MSVC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP /Zc:__cplusplus")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP /Zc:__cplusplus")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -no-pie")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -no-pie")
    if(CMAKE_BUILD_TYPE MATCHES "Debug")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3")
    endif()
    #[[
    # the options for the shared library
    set(LINK_FLAGS )
    # the linker options
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LINK_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LINK_FLAGS}")
    ]]
endif()

#outpath
# debug
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/debug/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/debug/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/debug/lib)
# release
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/release/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/release/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/release/lib)

if(CMAKE_INSTALL_PREFIX STREQUAL "")
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/output" CACHE PATH "cmake install prefix")
endif()

# check system and compiler info
if(NOT ARCH_PLAT_VENDOR)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(ARCH x64)
    else()
        set(ARCH x86)
    endif()
    if(APPLE)
        set(PLAT "apple")
    else()
        string(TOLOWER "${CMAKE_SYSTEM_NAME}" PLAT)
    endif()
    #if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    if(WIN32)
        set(VENDOR "vs2019")
    else()
        set(VENDOR "gcc9.3.0")
    endif()
    set(ARCH_PLAT_VENDOR "${ARCH}-${PLAT}-${VENDOR}")
endif()

if(WIN32)
    add_compile_options(/wd4819)
else()
endif()

#if(CMAKE_BUILD_TYPE MATCHES "Debug")
#add_definitions("-DJNI_NORMAL" "-DJNI_PERFORMANCE")
#endif()

#message(STATUS "version: ${VERSION_FULL}, ${VERSION_TIME}")
message(STATUS "build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "ARCH_PLAT_VENDOR: ${ARCH_PLAT_VENDOR}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")