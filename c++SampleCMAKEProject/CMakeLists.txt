#Establish minimum version
cmake_minimum_required (VERSION "3.10")
project ("Sample Project" "CXX" "C")

#Define c++ 17 as default standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=* -fix -format-style=file)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

#Take all sources in src to build main file
aux_source_directory("src" "project_src")
add_executable(sampleProject ${project_src})

#Find boost lib
find_package(Boost REQUIRED)
#find_package(Boost COMPONENTS program_options REQUIRED)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})

#Add the GSL support library headers to the include directories
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/GSL/include)

#Config clang-format to be run before each build
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
find_package(ClangFormat REQUIRED)
add_custom_target(format ALL
  ${CLANG_FORMAT_EXECUTABLE} -style=file -i -sort-includes ${project_src}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

TARGET_LINK_LIBRARIES(sampleProject ${Boost_LIBRARIES})
