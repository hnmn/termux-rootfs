# Depend packages
if(NOT ZLIB_FOUND)
  find_package(ZLIB)
endif()
if(NOT Protobuf_FOUND)
  find_package(Protobuf)
endif()
if(NOT OpenSSL_FOUND)
  find_package(OpenSSL)
endif()

# Targets
include(${CMAKE_CURRENT_LIST_DIR}/gRPCTargets.cmake)
