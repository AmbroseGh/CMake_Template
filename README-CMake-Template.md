# CMakeTemplate

This template includes:  
- A clean, modern `CMakeLists.txt`
- A suite of reusable CMake modules
- A `CMakePresets.json` for all platforms
- Optional tooling (clang-tidy, IWYU, sanitizers)
- Editor tooling configuration

Not Finished:  
- Sanitizers
- Tests

## Directory Structure
project/  
│  
├── CMakeLists.txt  
├── CMakePresets.json  
│  
├── cmake/  
│   ├── StandardProjectSettings.cmake  
│   ├── CompilerWarnings.cmake  
│   ├── CompilerOptions.cmake  
│   ├── Sanitizers.cmake  
│   └── ClangTools.cmake  
│  
├── project/  
│  
├── .clang-format  
├── .clang-tidy  
└── .clangd  

## Root `CMakeLists.txt`

The root CMake file:  
- Defines the project
- Loads reusable modules
- Sets up options (warnings, sanitizers, clang-tidy, tests)
- Creates a placeholder target
- Applies standard settings

## CMake Modules

All reusable logic lives in `cmake/` so your root file stays clean.  

**StandardProjectSettings.cmake**  
Sets global defaults:  
- C++ standard (C++20)
- Default build type
- Position-independent code
- RPATH behavior
- IDE folder grouping

**CompilerWarnings.cmake**  
Provides warning flags for MSVC, GCC, and Clang.  

**CompilerOptions.cmake**  
Adds:  
- LTO (if supported)
- Frame pointer settings
- MSVC conformance flags

**Sanitizers.cmake (Unfinished)**  
Enables:  
- ASan
- UBSan
- TSan
Automatically applies compile + link flags.  

**ClangTools.cmake**
Integrates:  
- clang-tidy
- include-what-you-use
- clang-format target

## Optional Features (via CMake options)

The template exposes several toggles:  
| Option | Default | Purpose |
| --- | --- | --- |
| ``ENABLE_WARNINGS`` | ON | Apply strong warnings |
| ``ENABLE_SANITIZERS`` | OFF | Enable ASan/UBSan/TSan |
| ``ENABLE_CLANG_TIDY`` | OFF | Enable clang‑tidy |
| ``ENABLE_TESTING`` | OFF | Enable CTest + tests/ |
These options integrate directly with the modules.  

## CMake Presets

**Base preset**  
- Ninja generator
- Standard output directories
- `compile_commands.json`

**Platform presets**  
- `windows-msvc`
- `windows-clang`
- `linux-gcc`
- `linux-clang`
- `macos`

**Build-type presets**
- `release`
- `relwithdebinfo`

**Feature presets**  
- `asan`
- `ubsan`
- `dev-tools` (clang-tidy + IWYU)

**Build presets**  
Each configure preset has a matching build preset.  

**Test preset**  
Run tests with output on failure.  

## Tooling Configuration

`.clang-format` defines the formatting style.  
`.clang-tidy`  
`.clangd` ensures lsp functionality.  

## Building

**1. Configure a build**  
`cmake --preset linux-clang`  

**2. Build**  
`cmake --build --preset linux-clang`  

**3. Run tests**
`ctest --preset test`  

**4. Enable sanitizers**  
`cmake --preset asan`  

**5. Enable dev tools**  
`cmake --preset dev-tools`  

## Customizing for a New Project

WIP.
