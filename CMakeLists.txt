cmake_minimum_required (VERSION 2.8.11)
project (arduino_libs)

set(CPPLINT_BIN cpplint)
set(LIB_SRC "${CMAKE_SOURCE_DIR}/src")

add_custom_target(cpplint_check COMMAND ${CPPLINT_BIN} --repository "${LIB_SRC}" --recursive "${LIB_SRC}")

include_directories(${LIB_SRC})

add_library(SevenSegmentDisplay STATIC ${LIB_SRC}/SevenSegmentDisplay/SevenSegmentDisplay.cc)
add_dependencies(SevenSegmentDisplay cpplint_check)
set_target_properties(SevenSegmentDisplay
  PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/dist/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/dist/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/dist/bin"
)


option(WithTests "Build all tests." OFF)
if (WithTests)
    enable_testing()

    # Needs for Google Test Framework
    find_package(Threads REQUIRED)

    # External project gtest
    add_subdirectory(external/gtest)
    include_directories(${GTEST_INCLUDE_DIRS})
    include_directories(${GMOCK_INCLUDE_DIRS})

    # External project arduino_mock
    add_subdirectory(external/arduino_mock)
    include_directories(${ARDUINO_MOCK_INCLUDE_DIRS})

    target_link_libraries(SevenSegmentDisplay
        ${ARDUINO_MOCK_LIBS_DIR}/dist/lib/libarduino_mock.a
        ${GTEST_LIBS_DIR}/libgtest_main.a
        ${GMOCK_LIBS_DIR}/libgmock.a
        ${CMAKE_THREAD_LIBS_INIT}
    )
    add_dependencies(SevenSegmentDisplay arduino_mock gtest)

    add_subdirectory(tests)
endif()
