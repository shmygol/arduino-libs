cmake_minimum_required (VERSION 2.8.11)
project (arduino_libs_tests)

add_executable(SevenSegmentDisplayTest SevenSegmentDisplay/SevenSegmentDisplayTest.cc)
target_link_libraries(SevenSegmentDisplayTest
    ${ARDUINO_MOCK_LIBS_DIR}/dist/lib/libarduino_mock.a
    ${GTEST_LIBS_DIR}/libgtest_main.a
    ${GMOCK_LIBS_DIR}/libgmock.a
    ${CMAKE_THREAD_LIBS_INIT}
)
add_dependencies(SevenSegmentDisplayTest SevenSegmentDisplay arduino_mock gtest)

add_test(SevenSegmentDisplayTest SevenSegmentDisplayTest)
