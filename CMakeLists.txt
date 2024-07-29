# AQEMU CMake Project

# Authors:
# Andrey Rijov (AQEMU developer)
# Timothy Redaelli (Fix for build in a different folder)
# Tobias Gläßer (Qt5 port)

cmake_minimum_required( VERSION 3.10.0 FATAL_ERROR )

project( AQEMU
	VERSION 0.9.6.9999
	DESCRIPTION "A Qt GUI for virtual machines using QEMU as the backend"
	HOMEPAGE_URL "https://github.com/tobimensch/aqemu"
	LANGUAGES CXX )

# Print project details
message(STATUS "Project: ${PROJECT_NAME} ${PROJECT_VERSION}")
message(STATUS "Description: ${PROJECT_DESCRIPTION}")
message(STATUS "Homepage: ${PROJECT_HOMEPAGE_URL}")
message(STATUS "Author: ${PROJECT_AUTHOR}")
message(STATUS "License: ${PROJECT_LICENSE}")

# Set the C++ standard to C++23 and ensure it's required.
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Available options
option( DEBUG "Build with debug information" )
option( WITHOUT_EMBEDDED_DISPLAY "Build without support Embedded VNC Display" )
option( UPDATE_TRANSLATIONS "Update source translation files (WARNING: make clean will delete the source .ts files!)" )
option( INSTALL_MAN "Install MAN page file" "ON" )

# Debug mode
if( DEBUG )
	# Verbose compiler output
	set( CMAKE_VERBOSE_MAKEfile ON )

	# GCC
	add_definitions( -Wall -g )
endif( DEBUG )

# Include necessary CMake modules
include(GNUInstallDirs)
include(FindDoxygen)
include(FindGSL)
include(CMakeParseArguments)

# For finding VNC libs - and other cmake functionality
set( CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/resources/cmake/modules )

# Include custom CMake scripts
include("${CMAKE_MODULE_PATH}/Sanitizers.cmake")
include("${CMAKE_MODULE_PATH}/ClangFormat.cmake")
#include("${CMAKE_MODULE_PATH}/ClangTidy.cmake")
include("${CMAKE_MODULE_PATH}/Configure.cmake")
include("${CMAKE_MODULE_PATH}/BuildDoc.cmake")

# Files
set( aqemu_headers
    src/No_Boot_Device.h
    src/Highlighted_Label.h
    src/Service.h
    src/Run_Guard.h
    src/QEMU_Docopt.h
    src/IP_Edit.h
    src/Dialog_Button_Box.h
	src/docopt/docopt.h
    	src/Settings_Widget.h
    	src/QDom.h
    	src/tinyxml2.h
	src/About_Window.h
	src/Add_New_Device_Window.h
	src/Add_Port_Window.h
	src/Add_USB_Port_Window.h
	src/Advanced_Settings_Window.h
	src/Boot_Device_Window.h
	src/Convert_HDD_Image_Window.h
	src/Copy_VM_Window.h
	src/Create_HDD_Image_Window.h
	src/Create_Template_Window.h
	src/Delete_VM_Files_Window.h
	src/Device_Manager_Widget.h
	src/Edit_Emulator_Version_Window.h
	src/Emulator_Control_Window.h
	src/Error_Log_Window.h
	src/First_Start_Wizard.h
	src/Folder_Sharing_Widget.h
	src/HDD_Image_Info.h
	src/Main_Window.h
	src/Monitor_Window.h
	src/Network_Widget.h
	src/Old_Network_Widget.h
	src/Ports_Tab_Widget.h
	src/Properties_Window.h
	src/Emulator_Options_Window.h
	src/Select_Icon_Window.h
	src/SMP_Settings_Window.h
	src/Snapshot_Properties_Window.h
	src/Snapshots_Window.h
	src/SPICE_Settings_Widget.h
	src/System_Info.h
	src/Utils.h
	src/VM.h
	src/VM_Devices.h
	src/VM_Wizard_Window.h
	src/VNC_Password_Window.h
)

set( aqemu_sources
    src/No_Boot_Device.cpp
    src/Highlighted_Label.cpp
    src/Service.cpp
    src/Run_Guard.cpp
    src/QEMU_Docopt.cpp
    src/IP_Edit.cpp
    src/Dialog_Button_Box.cpp
	src/docopt/docopt.cpp
	src/Settings_Widget.cpp
    	src/QDom.cpp
    	src/tinyxml2.cpp
	src/About_Window.cpp
	src/Add_New_Device_Window.cpp
	src/Add_Port_Window.cpp
	src/Add_USB_Port_Window.cpp
	src/Advanced_Settings_Window.cpp
	src/Boot_Device_Window.cpp
	src/Convert_HDD_Image_Window.cpp
	src/Copy_VM_Window.cpp
	src/Create_HDD_Image_Window.cpp
	src/Create_Template_Window.cpp
	src/Delete_VM_Files_Window.cpp
	src/Device_Manager_Widget.cpp
	src/Edit_Emulator_Version_Window.cpp
	src/Emulator_Control_Window.cpp
	src/Error_Log_Window.cpp
	src/First_Start_Wizard.cpp
	src/Folder_Sharing_Widget.cpp
	src/HDD_Image_Info.cpp
	src/main.cpp
	src/Main_Window.cpp
	src/Monitor_Window.cpp
	src/Network_Widget.cpp
	src/Old_Network_Widget.cpp
	src/Ports_Tab_Widget.cpp
	src/Properties_Window.cpp
	src/Emulator_Options_Window.cpp
	src/Select_Icon_Window.cpp
	src/SMP_Settings_Window.cpp
	src/Snapshot_Properties_Window.cpp
	src/Snapshots_Window.cpp
	src/SPICE_Settings_Widget.cpp
	src/System_Info.cpp
	src/Utils.cpp
	src/VM.cpp
	src/VM_Devices.cpp
	src/VM_Wizard_Window.cpp
	src/VNC_Password_Window.cpp
)

set( aqemu_ui
    src/No_Boot_Device.ui
	src/About_Window.ui
	src/Add_New_Device_Window.ui
	src/Add_Port_Window.ui
	src/Add_USB_Port_Window.ui
	src/Advanced_Settings_Window.ui
	src/Boot_Device_Window.ui
	src/Convert_HDD_Image_Window.ui
	src/Copy_VM_Window.ui
	src/Create_HDD_Image_Window.ui
	src/Create_Template_Window.ui
	src/Delete_VM_Files_Window.ui
	src/Device_Manager_Widget.ui
	src/Edit_Emulator_Version_Window.ui
	src/Emulator_Control_Window.ui
	src/Error_Log_Window.ui
	src/First_Start_Wizard.ui
	src/Folder_Sharing_Widget.ui
	src/Main_Window.ui
	src/Monitor_Window.ui
	src/Network_Widget.ui
	src/Old_Network_Widget.ui
	src/Ports_Tab_Widget.ui
	src/Properties_Window.ui
	src/Emulator_Options_Window.ui
	src/Select_Icon_Window.ui
	src/Settings_Window.ui
	src/SMP_Settings_Window.ui
	src/Snapshot_Properties_Window.ui
	src/Snapshots_Window.ui
	src/SPICE_Settings_Widget.ui
	src/VM_Wizard_Window.ui
	src/VNC_Password_Window.ui
)

set( aqemu_qrc
    resources/shared_images.qrc
    resources/icons.qrc
)

set( aqemu_man_page
    resources/docs/aqemu.1 )

set( translations
     translations/German.ts
     transtations/Russian.ts
     translations/Ukrainian.ts
     translations/French.ts
     translations/English.ts )

set( files_to_translate ${files_to_translate} ${aqemu_headers} ${aqemu_sources} ${aqemu_ui} )

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
# Instruct CMake to run uic automatically when needed.
set(CMAKE_AUTOUIC ON)
# Instruct CMake to run rcc automatically when needed.
set(CMAKE_AUTORCC ON)

# Optionally handle documentation generation
option(BUILD_DOC "Build documentation with Doxygen." OFF)
if(BUILD_DOC)
	add_subdirectory(Documentation)
endif()

# Options to configure sanitizers
option(ENABLE_ASAN "Build with AddressSanitizer (ASan)." OFF)
option(ENABLE_LSAN "Build with LeakSanitizer (LSan)." OFF)
option(ENABLE_MSAN "Build with MemorySanitizer (MSan)." OFF)

# Add a custom command for the 'all' target to ensure that the compile_commands.json file is generated.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Check Qt
find_package(Qt5 COMPONENTS Core Widgets Network Test PrintSupport DBus REQUIRED)

# Embedded VNC display
if( NOT WITHOUT_EMBEDDED_DISPLAY )
	find_package( LibVNCServer REQUIRED )

	set( aqemu_headers ${aqemu_headers} src/Embedded_Display/Machine_View.h src/Embedded_Display/remoteview.h
										src/Embedded_Display/vncclientthread.h src/Embedded_Display/vncview.h )

	set( aqemu_sources ${aqemu_sources} src/Embedded_Display/Machine_View.cpp src/Embedded_Display/remoteview.cpp
										src/Embedded_Display/vncclientthread.cpp src/Embedded_Display/vncview.cpp )

	add_definitions( -DVNC_DISPLAY -DQTONLY )
endif( NOT WITHOUT_EMBEDDED_DISPLAY )

# TODO: port from Qt4 to Qt5
# For translation
#if( UPDATE_TRANSLATIONS )
#	QT5_CREATE_TRANSLATION( qm_files ${CMAKE_CURRENT_SOURCE_DIR} ${files_to_translate} ${translations} )
#ELSE( UPDATE_TRANSLATIONS )
#	QT5_ADD_TRANSLATION( qm_files ${translations} )
#endif( UPDATE_TRANSLATIONS )

add_custom_target( translations_target DEPENDS ${qm_files} )

if(COMMAND cmake_policy)
    cmake_policy(SET CMP0003 NEW)
endif()

ADD_EXECUTABLE( aqemu
	${aqemu_sources}
	${ui_headers}
	${moc_srcs}
	${qm_files}
	${aqemu_qrc}
)

# Handle custom scripts
handle_in_files(aqemu ${CMAKE_SOURCE_DIR})

# Configure sanitizers
handle_sanitizers(aqemu ${ENABLE_ASAN} ${ENABLE_LSAN} ${ENABLE_MSAN})

# Optionally enable additional warnings and compiler flags.
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	target_compile_options(aqemu PRIVATE -Wall -Wextra -Wpedantic -Wl,--verbose,-t)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	target_compile_options(aqemu PRIVATE -Wall -Wextra -Wpedantic)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
	target_compile_options(aqemu PRIVATE /W4 /WX)
endif()

target_include_directories(aqemu PUBLIC src/ )

# Require C++-11 standard
# set_property(TARGET aqemu PROPERTY CXX_STANDARD 11)
# set_property(TARGET aqemu PROPERTY CXX_STANDARD_REQUIRED ON)

target_link_libraries(aqemu
	Qt5::Widgets
	Qt5::Network
	Qt5::Test
	Qt5::PrintSupport
	Qt5::DBus
)

# Embedded VNC display
if( NOT WITHOUT_EMBEDDED_DISPLAY )
	target_link_libraries( aqemu ${LIBVNCCLIENT_LIBRARIES} )
endif( NOT WITHOUT_EMBEDDED_DISPLAY )

# Install files
install( TARGETS aqemu
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} )

# Install data files and directories
install(
    FILES
        ${qm_files}
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/docs/links.html
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/aqemu.desktop
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/aqemu.appdata.xml
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/*.png
    DESTINATION
        ${CMAKE_INSTALL_DATADIR}/aqemu
)

# Install directories
install(
    DIRECTORY
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/os_icons/
        ${CMAKE_CURRENT_SOURCE_DIR}/resources/os_templates/
    DESTINATION
        ${CMAKE_INSTALL_DATADIR}/aqemu
)

#install( FILES ${qm_files} DESTINATION share/aqemu )

# file( GLOB os_icons "${CMAKE_CURRENT_SOURCE_DIR}/resources/os_icons/*.*" )
# install( files ${os_icons} DESTINATION share/aqemu/os_icons )
#
# file( GLOB os_templates "${CMAKE_CURRENT_SOURCE_DIR}/resources/os_templates/*.*")
# install( files ${os_templates} DESTINATION share/aqemu/os_templates )
#
# file( GLOB links "${CMAKE_CURRENT_SOURCE_DIR}/resources/docs/links.html" )
# install( files ${links} DESTINATION share/aqemu/docs )
#
# file( GLOB pixmaps "${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/*.png" )
# install( files ${pixmaps} DESTINATION share/pixmaps )
#
# file( GLOB app_menu "${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/aqemu.desktop" )
# install( files ${app_menu} DESTINATION share/applications )
#
# file( GLOB app_menu "${CMAKE_CURRENT_SOURCE_DIR}/resources/menu_data/aqemu.appdata.xml" )
# install( files ${app_menu} DESTINATION share/appdata )

# Create docs .bz2 files
macro( create_docs _sources )
	foreach( curFile ${ARGN} )
		get_filename_component( _in ${curFile} ABSOLUTE )
		get_filename_component( _basename ${curFile} NAME_WE )

		set( _out ${CMAKE_CURRENT_SOURCE_DIR}/${_basename}.bz2 )

		add_custom_command( OUTPUT ${_out} COMMAND bzip2 ARGS -zkf9 ${_in} DEPENDS ${_in} )

		set( ${_sources} ${${_sources}} ${_out} )
	endforeach( curFile )
endmacro( create_docs )

CREATE_DOCS( docs_bz2 AUTHORS CHANGELOG README TODO )
add_custom_target( docs ALL DEPENDS ${docs_bz2} )
install( FILES ${docs_bz2} DESTINATION ${CMAKE_INSTALL_DOCDIR}/aqemu )

# Compress and install MAN page file
if( NOT MAN_PAGE_COMPRESSOR )
	message( STATUS "MAN page will be installed is not packed." )
elseif( MAN_PAGE_COMPRESSOR STREQUAL "gzip" )
	set( COMPRESSOR_SUFFIX gz )
elseif( MAN_PAGE_COMPRESSOR STREQUAL "bzip2" )
	set( COMPRESSOR_SUFFIX bz2 )
elseif( MAN_PAGE_COMPRESSOR STREQUAL "lzma" )
	set( COMPRESSOR_SUFFIX lzma )
else( NOT MAN_PAGE_COMPRESSOR )
	message( STATUS "${MAN_PAGE_COMPRESSOR} not supported!" )
	message( FATAL_ERROR "Correct values: gzip, bzip2, lzma" )
endif( NOT MAN_PAGE_COMPRESSOR )

# Compress MAN file?
if( INSTALL_MAN )
	if( COMPRESSOR_SUFFIX )
		# Find gzip, bzip or lzma
		find_program( COMPRESSOR_BIN NAMES ${MAN_PAGE_COMPRESSOR} )

		if( ${COMPRESSOR_BIN} MATCHES COMPRESSOR_BIN-NOTFOUND )
			message( STATUS "${MAN_PAGE_COMPRESSOR} - NOT FOUND!" )
			message( FATAL_ERROR "Please install ${MAN_PAGE_COMPRESSOR} package!" )
		endif( ${COMPRESSOR_BIN} MATCHES COMPRESSOR_BIN-NOTFOUND )

		# Compress
		execute_process( OUTPUT_FILE ${aqemu_man_page}.${COMPRESSOR_SUFFIX}
						COMMAND "${COMPRESSOR_BIN}" -9
						INPUT_FILE ${aqemu_man_page}
						WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} )

		# Install MAN
		install( FILES ${CMAKE_SOURCE_DIR}/${aqemu_man_page}.${COMPRESSOR_SUFFIX} DESTINATION ${CMAKE_INSTALL_MANDIR}/man1 )
	else( COMPRESSOR_SUFFIX )
		message( STATUS "MAN_PAGE_COMPRESSOR flag not set. Available values: gzip, bzip2, lzma" )
		message( STATUS "Will be installed not compressed MAN pages" )

		install( FILES ${CMAKE_SOURCE_DIR}/${aqemu_man_page} DESTINATION ${CMAKE_INSTALL_MANDIR}/man1 )
	endif( COMPRESSOR_SUFFIX )
endif( INSTALL_MAN )
