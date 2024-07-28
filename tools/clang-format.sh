#!/bin/bash

#Make sure it is installed first. Else inform the user.
# if (! command -v clang-format &> /dev/null )
# then
#     echo "clang-format could not be found. Install it or make it visible under the PATH."
#     exit
# fi
#
# find ../ -regex '.*\.\(cpp\|hpp\|cxx\|ixx\|cu\|c\|h\)' -exec clang-format --verbose -style=file:../.clang-format -i {} \;

# Function to display usage
usage() {
    echo "Usage: $0 [-d search_directory] [-f clang_format_file] [-h]"
    echo "  -d search_directory: Directory to search for source files (default: ../)"
    echo "  -f clang_format_file: Path to the .clang-format file (default: ../.clang-format)"
    echo "  -h: Display this help message"
}

# Default values
SEARCH_DIR="../"
CLANG_FORMAT_FILE="../.clang-format"

# Parse command line arguments
while getopts "d:f:h" opt; do
    case ${opt} in
        d )
            SEARCH_DIR=$OPTARG
            ;;
        f )
            CLANG_FORMAT_FILE=$OPTARG
            ;;
        h )
            usage
            exit 0
            ;;
        \? )
            usage
            exit 1
            ;;
    esac
done

# Ensure clang-format is installed
if ! command -v clang-format &> /dev/null; then
    echo "Error: clang-format could not be found. Install it or make it visible under the PATH."
    exit 1
fi

# Ensure the search directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Search directory '$SEARCH_DIR' does not exist."
    exit 1
fi

# Ensure the clang-format file exists
if [ ! -f "$CLANG_FORMAT_FILE" ]; then
    echo "Error: clang-format file '$CLANG_FORMAT_FILE' does not exist."
    exit 1
fi

# Find and format the files
echo "Searching for source files in '$SEARCH_DIR'..."
find "$SEARCH_DIR" -regex '.*\.\(cpp\|hpp\|cxx\|ixx\|cu\|c\|h\)' -print0 | xargs -0 -n 1 -P 8 clang-format --verbose -style=file:"$CLANG_FORMAT_FILE" -i

# Check the exit status of the find command
if [ $? -eq 0 ]; then
    echo "Formatting completed successfully."
else
    echo "Error: An error occurred during formatting."
    exit 1
fi
