cmake_minimum_required(VERSION 3.0.0)
project(cpp-template VERSION 0.1.0)

# set c++ standard and output directory
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "$<0:>${CMAKE_CURRENT_SOURCE_DIR}/target")

# build file list with all header- and sourcefiles
file(GLOB_RECURSE APP_SOURCES "src/*.h" "src/*.hpp" "src/*.cpp")
add_executable(${PROJECT_NAME} ${APP_SOURCES})

# Import SFML
if (WIN32)
  set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third-party/SFML")
elseif (APPLE)
  set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third-party/SFML/Frameworks")
endif()

set(SFML_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/third-party/SFML/bin")
find_package(SFML 2.5 COMPONENTS system window graphics network audio REQUIRED)
include_directories(${PROJECT_NAME} ${SFML_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} sfml-system sfml-window sfml-graphics sfml-network sfml-audio)

if (WIN32)
  set(SFML_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/third-party/SFML/bin")
  list(APPEND THIRD_PARTY_LIBS "${SFML_BIN_DIR}/openal32.dll"
    "${SFML_BIN_DIR}/sfml-audio-$<$<CONFIG:Debug>:d->2.dll"
    "${SFML_BIN_DIR}/sfml-graphics-$<$<CONFIG:Debug>:d->2.dll"
    "${SFML_BIN_DIR}/sfml-network-$<$<CONFIG:Debug>:d->2.dll"
    "${SFML_BIN_DIR}/sfml-system-$<$<CONFIG:Debug>:d->2.dll"
    "${SFML_BIN_DIR}/sfml-window-$<$<CONFIG:Debug>:d->2.dll"
  )

  # copy dll files to target directory
  foreach( file_i ${THIRD_PARTY_LIBS})
      add_custom_command(
      TARGET ${PROJECT_NAME}
      POST_BUILD
      COMMAND ${CMAKE_COMMAND}
      ARGS -E copy_if_different ${file_i} $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )
  endforeach( file_i )
elseif(APPLE)
  add_custom_command(TARGET ${PROJECT_NAME}  POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${CMAKE_CURRENT_SOURCE_DIR}/third-party/SFML/Frameworks
                ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Frameworks)
  add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND install_name_tool -add_rpath @loader_path/Frameworks $<TARGET_FILE_DIR:${PROJECT_NAME}>/${PROJECT_NAME})
endif()
