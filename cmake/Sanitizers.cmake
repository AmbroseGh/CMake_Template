
# enable_sanitizers(${PROJECT_NAME})
function(enable_sanitizers target)
    if(MSVC)
        message(WARNING "Sanitizers are not supported on MSVC")
        return()
    endif()

    set(sanitize_flags "")

    if(ENABLE_SANITIZERS MATCHES "address")
        list(APPEND sanitize_flags -fsanitize=address)
    endif()

    if(ENABLE_SANITIZERS MATCHES "undefined")
        list(APPEND sanitize_flags -fsanitize=undefined)
    endif()

    if(ENABLE_SANITIZERS MATCHES "thread")
        list(APPEND sanitize_flags -fsanitize=thread)
    endif()

    if(sanitize_flags)
        target_compile_options(${target} PRIVATE ${sanitize_flags})
        target_link_options(${target} PRIVATE ${sanitize_flags})
    endif()
endfunction()
