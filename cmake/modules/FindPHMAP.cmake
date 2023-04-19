# Define a CMake module to find PHMAP header using find_package

# Usage: find_package(PHMAP [VERSION version] [REQUIRED] [QUIET])
#
# Searches for the PHMAP header file and sets the variable
# `PHMAP_FOUND` to `TRUE` if the header file is found,
# and sets the variable `PHMAP_INCLUDE_DIRS` to the include directories
# containing the header file.
#
# Example usage:
#   find_package(PHMAP REQUIRED)
# Define user options

if(NOT PHMAP_INCLUDE_DIR)
  message(STATUS "PHMAP_INCLUDE_DIR not defined, searching for PHMAP header")  
  find_path(PHMAP_INCLUDE_DIR parallel_hashmap/phmap.h
    HINTS $ENV{CONDA_PREFIX}/include
    PATH_SUFFIXES include
    DOC "Directory where the PHMAP header files are located"
  )
endif()

# Find PHMAP header
find_path(PHMAP_INCLUDE_DIRS
    NAMES phmap.h
    PATH_SUFFIXES include
)

# Check if PHMAP header is found
if(PHMAP_INCLUDE_DIR)
    message(STATUS "PHMAP found")
    set(PHMAP_FOUND TRUE)
else()
    set(PHMAP_FOUND FALSE)
endif()

# Standard package handling
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PHMAP REQUIRED_VARS PHMAP_INCLUDE_DIR)

mark_as_advanced(PHMAP_INCLUDE_DIR)
