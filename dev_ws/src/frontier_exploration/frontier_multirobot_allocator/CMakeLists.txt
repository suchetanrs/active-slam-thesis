cmake_minimum_required(VERSION 3.5)
project(frontier_multirobot_allocator VERSION 1.0)

# Default to C++20
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 20)
endif()

find_package(Eigen3 REQUIRED)

set(dependencies
  Eigen3
)

# Create library target
add_library(taskAllocator_lib src/hungarian/Hungarian.cpp src/minPos/minPos.cpp src/taskAllocator.cpp)

add_executable(hungExec src/hungarian/Hungarian.cpp src/hungarian/testMain.cpp)
add_executable(minPosExec src/hungarian/Hungarian.cpp src/minPos/minPos.cpp src/minPos/minPos_test.cpp)
# add_executable(voronoiExec src/voronoi/voronoi.cpp)
# add_executable(voronoiViz src/voronoi/voronoi_visualizer.cpp)
# Set include directory
target_include_directories(taskAllocator_lib
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        ${EIGEN3_INCLUDE_DIR}
)

target_include_directories(hungExec
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        ${EIGEN3_INCLUDE_DIR}
)

target_include_directories(minPosExec
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        ${EIGEN3_INCLUDE_DIR}
)

# target_include_directories(voronoiExec
#     PUBLIC
#         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#         $<INSTALL_INTERFACE:include>
#         ${EIGEN3_INCLUDE_DIR}
#         ${Boost_INCLUDE_DIRS} # Add Boost include directories
# )

# target_include_directories(voronoiViz
#     PUBLIC
#         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
#         $<INSTALL_INTERFACE:include>
#         ${EIGEN3_INCLUDE_DIR}
#         ${Boost_INCLUDE_DIRS} # Add Boost include directories
# )

# Link libraries
target_link_libraries(taskAllocator_lib
    ${EIGEN3_LIBS}
)
target_link_libraries(hungExec
   ${EIGEN3_LIBS}
)
target_link_libraries(minPosExec
   ${EIGEN3_LIBS}
)

# Generate and install CMake configuration file
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
    "Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION lib/cmake/${PROJECT_NAME}
)

install(TARGETS taskAllocator_lib
    EXPORT export_${PROJECT_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(EXPORT export_${PROJECT_NAME}
    FILE export_${PROJECT_NAME}.cmake
    DESTINATION lib/cmake/${PROJECT_NAME}
)

export(EXPORT export_${PROJECT_NAME}
    FILE "${CMAKE_CURRENT_BINARY_DIR}/export_${PROJECT_NAME}.cmake"
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    DESTINATION lib/cmake/${PROJECT_NAME}
)

install(DIRECTORY include/ DESTINATION include)
