# Define a CMake module to find dlpack header using find_package

# Usage: find_package(DLPack [VERSION version] [REQUIRED] [QUIET])
#
# Searches for the dlpack header file and sets the variable
# `DLPACK_FOUND` to `TRUE` if the header file is found,
# and sets the variable `DLPACK_INCLUDE_DIRS` to the include directories
# containing the header file.
#
# Example usage:
#   find_package(DLPack REQUIRED)

# Define module name and version
set(DLPACK_MODULE_NAME "DLPack")
set(DLPACK_MODULE_VERSION "1.0")

# Define user options
option(DLPACK_INCLUDE_DIRS "Include directories for DLPack" ON)

# Find dlpack header
find_path(DLPACK_INCLUDE_DIRS
    NAMES dlpack/dlpack.h
    PATH_SUFFIXES include
)

# Check if dlpack header is found
if(DLPACK_INCLUDE_DIRS)
    set(DLPACK_FOUND TRUE)
else()
    set(DLPACK_FOUND FALSE)
endif()

# Create imported target
if(DLPACK_FOUND)
    add_library(${DLPACK_MODULE_NAME} INTERFACE)
    target_include_directories(${DLPACK_MODULE_NAME} INTERFACE ${DLPACK_INCLUDE_DIRS})
else()
    if(REQUIRED)
        message(FATAL_ERROR "DLPack header not found")
    elseif(NOT QUIET)
        message(STATUS "DLPack header not found")
    endif()
endif()

# Export module variables
set(DLPACK_INCLUDE_DIRS ${DLPACK_INCLUDE_DIRS} CACHE INTERNAL "${DLPACK_MODULE_NAME} include directories")
mark_as_advanced(DLPACK_INCLUDE_DIRS)
