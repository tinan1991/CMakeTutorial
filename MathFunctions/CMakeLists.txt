add_executable(MakeTable MakeTable.cpp)
# add the command to generate the source code
add_custom_command (
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  DEPENDS MakeTable
  )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_library(MathFunctions MathFunctions.cpp ${CMAKE_CURRENT_BINARY_DIR}/Table.h)

install(TARGETS MathFunctions CONFIGURATIONS Release DESTINATION ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE})
install(FILES MathFunctions.h  CONFIGURATIONS Release DESTINATION ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE}/include)

install(TARGETS MathFunctions CONFIGURATIONS Debug DESTINATION ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG})
install(FILES MathFunctions.h  CONFIGURATIONS Debug DESTINATION ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG}/include)