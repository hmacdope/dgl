# Define a CMake module to find XBYAK header using find_package

# Usage: find_package(XBYAK [VERSION version] [REQUIRED] [QUIET])
#
# Searches for the XBYAK header file and sets the variable
# `XBYAK_FOUND` to `TRUE` if the header file is found,
# and sets the variable `XBYAK_INCLUDE_DIRS` to the include directories
# containing the header file.
#
# Example usage:
#   find_package(XBYAK REQUIRED)
# Define user options

if(NOT XBYAK_INCLUDE_DIR)
  message(STATUS "XBYAK_INCLUDE_DIR not defined, searching for XBYAK header")  
  find_path(XBYAK_INCLUDE_DIR xbyak/xbyak.h
    HINTS $ENV{CONDA_PREFIX}/include
    PATH_SUFFIXES include
    DOC "Directory where the XBYAK header files are located"
  )
endif()

# Find XBYAK header
find_path(XBYAK_INCLUDE_DIRS
    NAMES xbyak.h
    PATH_SUFFIXES include
)

# Check if XBYAK header is found
if(XBYAK_INCLUDE_DIR)
    message(STATUS "XBYAK found")
    set(XBYAK_FOUND TRUE)
else()
    set(XBYAK_FOUND FALSE)
endif()

# Standard package handling
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(XBYAK REQUIRED_VARS XBYAK_INCLUDE_DIR)

mark_as_advanced(XBYAK_INCLUDE_DIR)
