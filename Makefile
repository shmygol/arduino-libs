
# === Custom Variables ===

BUILD_DIR = build

# List of libraries 
LIB_NAMES = SevenSegmentDisplay

# Points to the root of Google Test, relative to where this file is.
GTEST_DIR = /usr/src/googletest/googletest

# Flags passed to the C++ compiler.
CXXFLAGS += -g -Wall -Wextra -pthread

# === Generated Variables ===

# Set Google Test's header directory as a system directory, such that
# the compiler doesn't generate warnings in Google Test headers.
CPPFLAGS += -isystem $(GTEST_DIR)/include

# All Google Test headers.
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h
GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

# List of file names for library objects (*.o files)
LIB_OBJECTS = $(patsubst %,$(BUILD_DIR)/%.o,$(LIB_NAMES))

# List of file names for library test objects (*Test.o files)
LIB_TEST_OBJECTS = $(patsubst %,$(BUILD_DIR)/%Test.o,$(LIB_NAMES))

# === Custom Functions ===

define basenamenotdir
$(basename $(notdir $(1)))
endef

define get_libname_from_test_object
$(patsubst %Test,%,$(call basenamenotdir,$(1)))
endef

# === Targets ===

all : $(LIB_OBJECTS)

clean :
	rm ./build/*

.SECONDEXPANSION: 
$(LIB_OBJECTS) : LIBNAME = $(call basenamenotdir,$@)

$(LIB_OBJECTS) : $$(LIBNAME)/$$(LIBNAME).cc $$(LIBNAME)/$$(LIBNAME).h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(call basenamenotdir,$@)/$(call basenamenotdir,$@).cc -o $@

run_tests : $(BUILD_DIR)/tests
	./$(BUILD_DIR)/tests

$(BUILD_DIR)/tests : $(LIB_OBJECTS) $(LIB_TEST_OBJECTS) $(BUILD_DIR)/gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@

.SECONDEXPANSION: 
$(LIB_TEST_OBJECTS) : LIBNAME = $(call get_libname_from_test_object,$@)

$(LIB_TEST_OBJECTS) : $(BUILD_DIR)/$$(LIBNAME).o $$(LIBNAME)/tests/$$(LIBNAME)Test.cc $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(call get_libname_from_test_object,$@)/tests/$(call get_libname_from_test_object,$@)Test.cc -o $@

# For simplicity and to avoid depending on Google Test's
# implementation details, the dependencies specified below are
# conservative and not optimized.  This is fine as Google Test
# compiles fast and for ordinary users its source rarely changes.
$(BUILD_DIR)/gtest-all.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest-all.cc -o $@

$(BUILD_DIR)/gtest_main.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest_main.cc -o $@

$(BUILD_DIR)/gtest.a : $(BUILD_DIR)/gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

$(BUILD_DIR)/gtest_main.a : $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

