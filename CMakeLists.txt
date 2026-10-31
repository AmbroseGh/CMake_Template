cmake_minimum_required(VERSION 4.1.2)

# -----------------
# Project metadata
# -----------------
project(MyProject VERSION 1.0.0 LANGUAGES CXX)

# -----------------
# Standard project settings
# -----------------
include(cmake/StandardProjectSettings.cmake)

# -----------------
# Options
# -----------------
option(ENABLE_WARNINGS "Enable compiler warnings" ON)
option(ENABLE_SANITIZERS "Enable sanitizers" OFF)
option(ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
option(ENABLE_TESTING "Enable tests" OFF)
option(ENABLE_DEVTOOLS "Enable developer tools" OFF)
option(ENABLE_ASSERTIONS "Enable assert()" OFF)
option(ENABLE_PROFILING "Enable profilng tools" OFF)

set(LOG_LEVEL "INFO" CACHE STRING "Logging level: ERROR, WARNING, INFO, DEBUG, TRACE")
set_property(CACHE LOG_LEVEL PROPERTY STRINGS ERROR WARNING INFO DEBUG TRACE)

# -----------------
# Warnings, sanitizers, clang-tidy, etc.
# -----------------
include(cmake/CompilerOptions.cmake)

if(ENABLE_WARNINGS)
    include(cmake/CompilerWarnings.cmake)
endif()

if(ENABLE_SANITIZERS)
    include(cmake/Sanitizers.cmake)
endif()

if(ENABLE_CLANG_TIDY)
    include(cmake/ClangTools.cmake)
endif()

# ---------------------------------

# --------------
# Main target (placeholder)
# --------------
add_executable(${PROJECT_NAME} project/project.cpp)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        project/include)

# Apply options to the target
if(ENABLE_WARNINGS)
    set_project_warnings(${PROJECT_NAME})
endif()

set_project_options(${PROJECT_NAME})

if(ENABLE_DEVTOOLS)
    target_compile_definitions(${PROJECT_NAME} PRIVATE PROJECT_ENABLE_DEVTOOLS=1)
endif()

if(NOT ENABLE_ASSERTIONS)
  target_compile_definitions(${PROJECT_NAME} PRIVATE NDEBUG)
endif()

if(ENABLE_PROFILING)
    target_compile_definitions(${PROJECT_NAME} PRIVATE PROJECT_ENABLE_PROFILING=1)
endif()

target_compile_definitions(${PROJECT_NAME} PRIVATE PROJECT_LOG_LEVEL="${LOG_LEVEL}")

# --------------
# Tests
# --------------
if(ENABLE_TESTING)
    enable_testing()
endif()
