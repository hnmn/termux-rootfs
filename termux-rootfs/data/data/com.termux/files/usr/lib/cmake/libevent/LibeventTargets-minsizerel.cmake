#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "event" for configuration "MinSizeRel"
set_property(TARGET event APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(event PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "m"
  IMPORTED_LOCATION_MINSIZEREL "/data/data/com.termux/files/usr/lib/libevent.so"
  IMPORTED_SONAME_MINSIZEREL "libevent.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS event )
list(APPEND _IMPORT_CHECK_FILES_FOR_event "/data/data/com.termux/files/usr/lib/libevent.so" )

# Import target "event_core" for configuration "MinSizeRel"
set_property(TARGET event_core APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(event_core PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "m"
  IMPORTED_LOCATION_MINSIZEREL "/data/data/com.termux/files/usr/lib/libevent_core.so"
  IMPORTED_SONAME_MINSIZEREL "libevent_core.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS event_core )
list(APPEND _IMPORT_CHECK_FILES_FOR_event_core "/data/data/com.termux/files/usr/lib/libevent_core.so" )

# Import target "event_extra" for configuration "MinSizeRel"
set_property(TARGET event_extra APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(event_extra PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "m"
  IMPORTED_LOCATION_MINSIZEREL "/data/data/com.termux/files/usr/lib/libevent_extra.so"
  IMPORTED_SONAME_MINSIZEREL "libevent_extra.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS event_extra )
list(APPEND _IMPORT_CHECK_FILES_FOR_event_extra "/data/data/com.termux/files/usr/lib/libevent_extra.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
