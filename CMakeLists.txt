cmake_minimum_required(VERSION 3.10)
project(Nvserv::rest CXX)


message(STATUS "Nvserv::rest : Configure")
message(STATUS "-----------------------")
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Main server development options
option(NVSERV_SERVER_REST  "Develop for server-side or REST API server" ON)

set(NVSERV_LIB_NAME "nvserv")


if(NOT NVSERV_CXX_VERSION)
    set(NVSERV_CXX_VERSION 17)
endif()

option(NVSERV_CXX_STANDARD_REQUIRED "CXX Required" ON)
option(NVSERV_CXX_EXTENSIONS "CXX Extensions" ON)

include(ProjectCXX)
set(ISROOT FALSE)
NV_DETECT_IS_ROOT_PROJECT(ISROOT)
message(STATUS "NvServ Root Project: ${ISROOT} ${NVSERV_CXX_VERSION}")

NV_PROPOGATE_CXX_OPTIONS(${NVSERV_CXX_VERSION} ${NVSERV_CXX_STANDARD_REQUIRED} ${NVSERV_CXX_EXTENSIONS})

set(CXX_FEATURE "")
NV_GET_CXX_STD_FEATURE(${NVSERV_CXX_VERSION} CXX_FEATURE)
message(STATUS "CXX Feature: ${CXX_FEATURE}")

if(ISROOT)
  set(NVSERV_USE_CATCH ON)
  set(NVSERV_USE_TEST ON)
  set(NVSERV_BUILD_EXAMPLE ON)
  set(NVSERV_SERVER_REST ON)
endif()

# Add Unit Test Lib Catch2
if(NVSERV_USE_CATCH)
 message(STATUS  "CATCH2::ADD_LIB.")
 find_package(Catch2 3 REQUIRED)
endif()

find_package(Threads REQUIRED)


# nvserv::rest
if(NVSERV_SERVER_REST)
  add_subdirectory(src/ build-nvserv_rest)
endif()