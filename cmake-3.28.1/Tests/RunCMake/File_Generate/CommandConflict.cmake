
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/output_$<CONFIGURATION>.txt"
              INPUT "${CMAKE_CURRENT_SOURCE_DIR}/input.txt"
              CONDITION $<CONFIG:$<CONFIGURATION>>
)
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/output_$<CONFIGURATION>.txt"
              INPUT "${CMAKE_CURRENT_SOURCE_DIR}/input.txt"
              CONDITION $<CONFIG:$<CONFIGURATION>>
)