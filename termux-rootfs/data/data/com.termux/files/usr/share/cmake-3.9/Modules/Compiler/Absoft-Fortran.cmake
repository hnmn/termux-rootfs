string(APPEND CMAKE_Fortran_FLAGS_INIT " ")
string(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT " -g")
string(APPEND CMAKE_Fortran_FLAGS_MINSIZEREL_INIT " ")
string(APPEND CMAKE_Fortran_FLAGS_RELEASE_INIT " -O3")
string(APPEND CMAKE_Fortran_FLAGS_RELWITHDEBINFO_INIT " -O2 -g")
set(CMAKE_Fortran_MODDIR_FLAG "-YMOD_OUT_DIR=")
set(CMAKE_Fortran_MODPATH_FLAG "-p")
set(CMAKE_Fortran_VERBOSE_FLAG "-v")
set(CMAKE_Fortran_FORMAT_FIXED_FLAG "-ffixed")
set(CMAKE_Fortran_FORMAT_FREE_FLAG "-ffree")