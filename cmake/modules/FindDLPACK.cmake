# Define a CMake module to find dlpack header using find_package

# Usage: find_package(DLPack [VERSION version] [REQUIRED] [QUIET])
#
# Searches for the dlpack header file and sets the variable
# `DLPACK_FOUND` to `TRUE` if the header file is found,
# and sets the variable `DLPACK_INCLUDE_DIRS` to the include directories
# containing the header file.
#
# Example usage:
#   find_package(DLPACK REQUIRED)
# Define user options

if(NOT DLPACK_INCLUDE_DIR)
  message(STATUS "EXTERNAL_DLPACK_PATH: ${EXTERNAL_DLPACK_PATH}")
  message(STATUS "DLPACK_INCLUDE_DIR not defined, searching for dlpack header in $ENV{DLPACK}/include" "$ENV{CONDA_PREFIX}/include" "$ENV{BUILD_PREFIX}/include")  
  find_path(DLPACK_INCLUDE_DIR dlpack/dlpack.h
    PATHS ${EXTERNAL_DLPACK_PATH}
    HINTS $ENV{DLPACK}/include $ENV{CONDA_PREFIX}/include $ENV{BUILD_PREFIX}/include
    PATH_SUFFIXES include
    DOC "Directory where the DLPACK header files are located"
  )
endif()

# Check if dlpack header is found
if(DLPACK_INCLUDE_DIR)
    message(STATUS "dlpack found at ${DLPACK_INCLUDE_DIR}")
    set(DLPACK_FOUND TRUE)
else()
    set(DLPACK_FOUND FALSE)
endif()

# Standard package handling
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DLPACK REQUIRED_VARS DLPACK_INCLUDE_DIR)

mark_as_advanced(DLPACK_INCLUDE_DIR)
