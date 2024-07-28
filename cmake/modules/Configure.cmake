# Function to handle the configuration of .in files and add them to the build process.
# This function generates the specified output files from the corresponding .in files
# and ensures they are included in the build dependencies of the given target.
#
# Arguments:
#   NAME_OF_TARGET - The name of the main target that will depend on the configured files.
#   SRC_DIR - The source directory containing the .in files and where the output files will be generated.
#
# Example usage:
#   handle_in_files(MyTarget ${CMAKE_SOURCE_DIR})
function(handle_in_files NAME_OF_TARGET SRC_DIR)
    # Set the CMake policy CMP0115 to NEW
    set(POLICY CMP0115 NEW)

    # Define the source .in files and their corresponding output files
    set(SOURCES

    )

    set(OUTPUTS

    )

    # Create configure_file commands for each source-output pair
    foreach(SRC_FILE IN LISTS SOURCES)
        # Get the index of the current source file
        list(FIND SOURCES ${SRC_FILE} i)
        # Get the corresponding output file path using the index
        list(GET OUTPUTS ${i} OUT_FILE)

        # Configure the file: Generate the output file from the source .in file
        configure_file(${SRC_FILE} ${OUT_FILE} @ONLY)
    endforeach()

    # Add a custom target that depends on the output files
    add_custom_target(config_files
        DEPENDS ${OUTPUTS}
    )

    # Add a dependency to the main target
    add_dependencies(${NAME_OF_TARGET} config_files)
endfunction()
