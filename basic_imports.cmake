cmake_minimum_required(VERSION 3.25)
include(FetchContent)

FetchContent_Declare(
  pico_sdk
  GIT_REPOSITORY https://github.com/raspberrypi/pico-sdk
  GIT_TAG        master
)
FetchContent_Declare(
  freertos_kernel
  GIT_REPOSITORY https://github.com/FreeRTOS/FreeRTOS-Kernel.git
  GIT_TAG        V11.0.1
)
FetchContent_Declare(
  freertos_default_config
  GIT_REPOSITORY https://github.com/jaguilar/freertos_default_config.git
  GIT_TAG        main
)
if (NOT EXISTS "$ENV{PICO_SDK_PATH}")
  message("Using Pico SDK from git")
  FetchContent_MakeAvailable(pico_sdk)
  set(PICO_SDK_PATH ${pico_sdk_SOURCE_DIR})
else()
  message("Using Pico SDK from environment")
  set(PICO_SDK_PATH "$ENV{PICO_SDK_PATH}")
endif()
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
if (NOT TARGET freertos_config)
  FetchContent_MakeAvailable(freertos_default_config)
endif()
if (NOT DEFINED FREERTOS_PORT)
  set(FREERTOS_PORT GCC_RP2040 CACHE STRING "")
endif()
if (NOT EXISTS "$ENV{FREERTOS_KERNEL_PATH}")
  message("Using FreeRTOS Kernel from git")
  FetchContent_Populate(freertos_kernel)
  set(FREERTOS_KERNEL_PATH ${freertos_kernel_SOURCE_DIR})
else()
  message("Using FreeRTOS Kernel from environment")
  set(FREERTOS_KERNEL_PATH "$ENV{FREERTOS_KERNEL_PATH}")
endif()
include(${FREERTOS_KERNEL_PATH}/portable/ThirdParty/GCC/RP2040/FreeRTOS_Kernel_import.cmake)

