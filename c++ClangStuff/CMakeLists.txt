#Establish minimum version
cmake_minimum_required (VERSION "3.5")
project ("LegacyBridge" "CXX")

#Take all sources in src to build main file
aux_source_directory("src" "project_src")
add_executable(LegacyBridge ${project_src})

#Find boost lib
find_package(Boost 1.58 COMPONENTS program_options REQUIRED)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})

#Define c++ 14 requirements
set_property(TARGET LegacyBridge PROPERTY CXX_STANDARD 14)
set_property(TARGET LegacyBridge PROPERTY CXX_STANDARD_REQUIRED ON)
set_property(TARGET LegacyBridge PROPERTY CXX_EXTENSIONS OFF)
TARGET_LINK_LIBRARIES(LegacyBridge ${Boost_LIBRARIES})
