cmake_minimum_required(VERSION 3.4)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBUSB REQUIRED libusb-1.0>=1.0.16)
pkg_check_modules(LIBZIP REQUIRED libzip)
find_package(Threads)

include_directories(${LIBUSB_INCLUDE_DIRS} include)

set(CMAKE_CXX_FLAGS_DEBUG "-g -Wall -Wstrict-aliasing -Wextra")
set(CMAKE_CXX_FLAGS "-O2")

set(SOURCES
	error.cpp
	buffer.cpp
	cmd.cpp
	config.cpp
	notify.cpp
	sdps.cpp
	trans.cpp
	usbhotplug.cpp
	version.cpp
	sdp.cpp
	gitversion.h
	fastboot.cpp
	zip.cpp
	fat.cpp
	rominfo.cpp
)

find_package(Git)
add_custom_target(git_version
	COMMAND ${CMAKE_COMMAND}
	-D PROJECT_VERSION=${PROJECT_NAME}_${PROJECT_VERSION}
	-D GIT_EXECUTABLE=${GIT_EXECUTABLE}
	-D INPUT_FILE=${CMAKE_CURRENT_SOURCE_DIR}/gitversion.h.in
	-D OUTPUT_FILE=${CMAKE_CURRENT_SOURCE_DIR}/gitversion.h
	-D GIT_SOURCE_DIR=${CMAKE_SOURCE_DIR}
	-P ${CMAKE_CURRENT_SOURCE_DIR}/gen_ver.cmake
)

#add_library( uuc SHARED ${SOURCES} ))
add_library( uuc_s STATIC ${SOURCES} )
add_dependencies( uuc_s git_version )
