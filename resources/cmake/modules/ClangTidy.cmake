# ClangTidy.cmake

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type" FORCE)
endif()

# Helper function to safely get environment variables
function(get_env_var var_name var_result)
  if(DEFINED ENV{${var_name}})
    set(${var_result} $ENV{${var_name}} PARENT_SCOPE)
  else()
    set(${var_result} "" PARENT_SCOPE)
  endif()
endfunction()

# Get environment variables for LLVM paths
get_env_var("ProgramFiles" PROGRAM_FILES)
get_env_var("ProgramFiles(x86)" PROGRAM_FILES_X86)
get_env_var("ProgramW6432" PROGRAM_W6432)

# Find clang-tidy executable
find_program(CLANG_TIDY_EXE NAMES "clang-tidy" HINTS
  ${LLVM_ROOT}/bin
  ${PROGRAM_FILES}/LLVM/bin
  ${PROGRAM_FILES_X86}/LLVM/bin
  ${PROGRAM_W6432}/LLVM/bin
)

if(NOT CLANG_TIDY_EXE)
  message(WARNING "clang-tidy not found!")
  return()
endif()

# Ensure .exe is appended for Windows
if(WIN32)
  set(CLANG_TIDY_EXE "${CLANG_TIDY_EXE}.exe")
endif()

# Set the CMake C++ Clang-Tidy configuration
set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE};-config-file=${CMAKE_SOURCE_DIR}/.clang-tidy")
