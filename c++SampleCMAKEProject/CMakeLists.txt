#Establish minimum version
cmake_minimum_required (VERSION "3.10")
project ("Sample Project1" "CXX" "C")

#Take all sources in src to build main file
aux_source_directory("src" "project_src")
add_executable(sampleProject ${project_src})

#Find boost lib
find_package(Boost REQUIRED)
#find_package(Boost COMPONENTS program_options REQUIRED)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})

#Define c++ 17 as default standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_CLANG_TIDY ${project_src} -checks=* -fix -format-style=file)
TARGET_LINK_LIBRARIES(sampleProject ${Boost_LIBRARIES})

#set_property(TARGET sampleProject PROPERTY CXX_STANDARD 17)
#set_property(TARGET sampleProject PROPERTY CXX_STANDARD_REQUIRED ON)
#set_property(TARGET sampleProject PROPERTY CXX_EXTENSIONS OFF)
