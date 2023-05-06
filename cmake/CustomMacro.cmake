MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()

MACRO(MSVC_MD_TO_MT )
  if (MSVC)
    set(CompilerFlags
        CMAKE_CXX_FLAGS
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_C_FLAGS
        CMAKE_C_FLAGS_DEBUG
        CMAKE_C_FLAGS_RELEASE
        )
    foreach(CompilerFlag ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
    endforeach()
  endif(MSVC)
ENDMACRO()

MACRO(GET_FOLDER_NAME name dir)
    STRING(REGEX REPLACE ".*/(.*)" "\\1" CURRENT_FOLDER ${dir})
ENDMACRO()

MACRO(GET_LIB_INFO path name version)
  set(base_dir ${path}/${name}/${version})
  if(NOT IS_DIRECTORY ${base_dir})
    #message(SEND_ERROR "${base_dir} not exist")
    message(WARNING "${base_dir} not exist")
  else()
    set(${name}_INCLUDE_DIR ${base_dir}/include CACHE INTERNAL "${name} include dir")
    set(${name}_LIB_DIR ${base_dir}/lib CACHE INTERNAL "${name} lib dir")
    set(${name}_BIN_DIR ${base_dir}/bin CACHE INTERNAL "${name} bin dir")
  endif()
ENDMACRO()

