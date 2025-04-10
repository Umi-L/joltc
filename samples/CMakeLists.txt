if (NOT JPH_SAMPLES)
    return ()
endif ()

function(add_sample SAMPLE_NAME)
    file(GLOB SOURCE_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.h"
	    "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.cpp"
    )

    if (ANDROID)
        add_library(${SAMPLE_NAME} SHARED ${SOURCE_FILES})
    else ()
    	add_executable(${SAMPLE_NAME} ${SOURCE_FILES})
    endif ()

    if (DOUBLE_PRECISION)
        target_link_libraries(${SAMPLE_NAME} LINK_PUBLIC joltc_double)
    else()
        target_link_libraries(${SAMPLE_NAME} LINK_PUBLIC joltc)
    endif ()

    if (EMSCRIPTEN)
        message("Adding emscripten specific flags")

        set(WASM_BUILD_FLAGS "\
        -s ALLOW_MEMORY_GROWTH \
        -sSTACK_SIZE=1048576 \
        -sINITIAL_MEMORY=134217728")

        set_target_properties(${SAMPLE_NAME} PROPERTIES LINK_FLAGS "${WASM_BUILD_FLAGS}")

    endif()

	if (MSVC)
		target_link_options(${SAMPLE_NAME} PUBLIC "/SUBSYSTEM:CONSOLE")
	endif()

    set_target_properties(${SAMPLE_NAME} PROPERTIES 
        VS_DEBUGGER_WORKING_DIRECTORY "$<TARGET_FILE_DIR:${SAMPLE_NAME}>"
        FOLDER "samples"
    )
endfunction()

# Add samples
add_sample(01_HelloWorld)