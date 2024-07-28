function(handle_dependency_clang_format)
    # Determine the operating system and set appropriate variables
    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
        # Windows-specific settings
        set(CLANG_FORMAT_CMD "clang-format.exe")
        set(CLANG_FORMAT_SCRIPT "clang-format.bat")
    else()
        # Unix-like systems settings
        set(CLANG_FORMAT_CMD "clang-format")
        set(CLANG_FORMAT_SCRIPT "clang-format.sh")
    endif()

    # Find the clang-format executable
    find_program(CLANG_FORMAT_EXECUTABLE NAMES ${CLANG_FORMAT_CMD})

    if(CLANG_FORMAT_EXECUTABLE)
        # Create a custom command to run clang-format
        add_custom_command(
            OUTPUT clang_format_
            COMMAND ${CMAKE_COMMAND} -P ${CMAKE_SOURCE_DIR}/tools/${CLANG_FORMAT_SCRIPT}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Running clang-format. Please wait until this job is finished."
        )

        # Define a custom target that depends on the custom command
        add_custom_target(clang_format
            DEPENDS clang_format_
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        )
    else()
        message(WARNING "CMake failed to create a target for clang-format. Is clang-format installed?")
    endif()
endfunction()
