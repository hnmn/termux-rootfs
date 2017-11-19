#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gr2_graphite2" for configuration "MinSizeRel"
set_property(TARGET gr2_graphite2 APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(gr2_graphite2 PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libgraphite2.so"
  IMPORTED_SONAME_MINSIZEREL "libgraphite2.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS gr2_graphite2 )
list(APPEND _IMPORT_CHECK_FILES_FOR_gr2_graphite2 "${_IMPORT_PREFIX}/lib/libgraphite2.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
