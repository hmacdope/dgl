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

if(NOT DMLC_INCLUDE_DIR)
  message(STATUS "DMLC_INCLUDE_DIR not defined, searching for dmlc header")  
  find_path(DMLC_INCLUDE_DIR dmlc/base.h
    HINTS $ENV{CONDA_PREFIX}/include
    PATH_SUFFIXES include
    DOC "Directory where the DMLC header files are located"
  )
endif()

# Find dlpack header
find_path(DMLC_INCLUDE_DIR
    NAMES dmlc/base.h
    PATH_SUFFIXES include
)

if(DMLC_LIBRARY)
  set(DMLC_LIBRARY ${DMLC_LIBRARY})
endif()
if(NOT DMLC_LIBRARY)
  message(STATUS "DMLC_LIBRARY not defined, searching for dmlc library")  
  find_library(DMLC_LIBRARY
    NAMES dmlc 
    HINTS $ENV{CONDA_PREFIX}/lib
    PATH_SUFFIXES lib
    DOC "Directory where the DMLC library is located"
  )
endif()


# Check if dlpack header is found
if(DMLC_INCLUDE_DIR AND DMLC_LIBRARY)
    message(STATUS "dmlc found include: ${DMLC_INCLUDE_DIR} lib: ${DMLC_LIBRARY}")
    set(DMLC_FOUND TRUE)
else()
    set(DMLC_FOUND FALSE)
endif()

# Standard package handling
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DMLC REQUIRED_VARS DLPACK_INCLUDE_DIR)

mark_as_advanced(DMLC_INCLUDE_DIR DMLC_LIBRARY)
