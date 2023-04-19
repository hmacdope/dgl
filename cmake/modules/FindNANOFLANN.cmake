# Define a CMake module to find NANOFLANN header using find_package

# Usage: find_package(NANOFLANN [VERSION version] [REQUIRED] [QUIET])
#
# Searches for the NANOFLANN header file and sets the variable
# `NANOFLANN_FOUND` to `TRUE` if the header file is found,
# and sets the variable `NANOFLANN_INCLUDE_DIRS` to the include directories
# containing the header file.
#
# Example usage:
#   find_package(NANOFLANN REQUIRED)
# Define user options

if(NOT NANOFLANN_INCLUDE_DIR)
  message(STATUS "NANOFLANN_INCLUDE_DIR not defined, searching for NANOFLANN header")  
  find_path(NANOFLANN_INCLUDE_DIR nanoflann.hpp
    HINTS $ENV{CONDA_PREFIX}/include
    PATH_SUFFIXES include
    DOC "Directory where the NANOFLANN header files are located"
  )
endif()

# Find NANOFLANN header
find_path(NANOFLANN_INCLUDE_DIRS
    NAMES nanoflann.hpp
    PATH_SUFFIXES include
)

# Check if NANOFLANN header is found
if(NANOFLANN_INCLUDE_DIR)
    message(STATUS "NANOFLANN found")
    set(NANOFLANN_FOUND TRUE)
else()
    set(NANOFLANN_FOUND FALSE)
endif()

# Standard package handling
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NANOFLANN REQUIRED_VARS NANOFLANN_INCLUDE_DIR)

mark_as_advanced(NANOFLANN_INCLUDE_DIR)
