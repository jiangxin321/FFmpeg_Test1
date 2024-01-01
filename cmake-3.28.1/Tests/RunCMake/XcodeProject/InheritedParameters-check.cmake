set(xcProjectFile "${RunCMake_TEST_BINARY_DIR}/InheritedParameters.xcodeproj/project.pbxproj")
if(NOT EXISTS "${xcProjectFile}")
  set(RunCMake_TEST_FAILED "Project file ${xcProjectFile} does not exist.")
  return()
endif()

set(found_inherited_GCC_PREPROCESSOR_DEFINITIONS 1)
set(found_inherited_OTHER_CFLAGS 1)
set(found_inherited_OTHER_LDFLAGS 1)
set(found_inherited_OTHER_SWIFT_FLAGS 1)
set(found_inherited_SWIFT_ACTIVE_COMPILATION_CONDITIONS 1)

file(STRINGS "${xcProjectFile}" lines)
foreach(line IN LISTS lines)

    if(line MATCHES [[GCC_PREPROCESSOR_DEFINITIONS]])
        if(NOT line MATCHES [["\$\(inherited\)"]])
            string(APPEND relevant_lines "  ${line}\n")
            set(found_inherited_GCC_PREPROCESSOR_DEFINITIONS 0)
        endif()
    endif()

    if(line MATCHES [[OTHER_CFLAGS]])
        if(NOT line MATCHES [["\$\(inherited\)"]])
            string(APPEND relevant_lines "  ${line}\n")
            set(found_inherited_OTHER_CFLAGS 0)
        endif()
    endif()

    if(line MATCHES [[OTHER_LDFLAGS]])
        if(NOT line MATCHES [["\$\(inherited\)"]])
            string(APPEND relevant_lines "  ${line}\n")
            set(found_inherited_OTHER_LDFLAGS 0)
        endif()
    endif()

    if(line MATCHES [[OTHER_SWIFT_FLAGS]])
      if(NOT line MATCHES [["\$\(inherited\)"]])
          string(APPEND relevant_lines "  ${line}\n")
          set(found_inherited_OTHER_SWIFT_FLAGS 0)
      endif()
    endif()

    if(line MATCHES [[SWIFT_ACTIVE_COMPILATION_CONDITIONS]])
      if(NOT line MATCHES [["\$\(inherited\)"]])
          string(APPEND relevant_lines "  ${line}\n")
          set(found_inherited_SWIFT_ACTIVE_COMPILATION_CONDITIONS 0)
      endif()
    endif()

endforeach()

if(NOT found_inherited_GCC_PREPROCESSOR_DEFINITIONS)
  string(APPEND RunCMake_TEST_FAILED "Found missing inherited value for GCC_PREPROCESSOR_DEFINITIONS in\n  ${xcProjectFile}\n")
endif()
if(NOT found_inherited_OTHER_CFLAGS)
  string(APPEND RunCMake_TEST_FAILED "Found missing inherited value for OTHER_CFLAGS in\n  ${xcProjectFile}\n")
endif()
if(NOT found_inherited_OTHER_LDFLAGS)
  string(APPEND RunCMake_TEST_FAILED "Found missing inherited value for OTHER_LDFLAGS in\n  ${xcProjectFile}\n")
endif()
if(CMake_TEST_Swift)
  if(NOT found_inherited_OTHER_SWIFT_FLAGS)
    string(APPEND RunCMake_TEST_FAILED "Found missing inherited value for OTHER_SWIFT_FLAGS in\n  ${xcProjectFile}\n")
  endif()
  if(NOT found_inherited_SWIFT_ACTIVE_COMPILATION_CONDITIONS)
    string(APPEND RunCMake_TEST_FAILED "Found missing inherited value for SWIFT_ACTIVE_COMPILATION_CONDITIONS in\n  ${xcProjectFile}\n")
  endif()
endif()

if(RunCMake_TEST_FAILED)
  string(APPEND RunCMake_TEST_FAILED "Relevant lines include\n${relevant_lines}")
endif()
