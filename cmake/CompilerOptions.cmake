function(set_project_options target)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT ipo_supported OUTPUT ipo_error)

    if(ipo_supported)
        set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE)
    endif()

    if(MSVC)
        target_compile_options(${target} PRIVATE
            /Zc:__cplusplus
        )
    else()
        target_compile_options(${target} PRIVATE
            -fno-omit-frame-pointer
        )
    endif()
endfunction()
