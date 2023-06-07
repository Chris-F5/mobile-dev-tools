# Download the SDK command line tools into SDK_PREFIX.
# Use sdkmanager to download build tools and a platform.
SDK_PREFIX=/opt/android-sdk
SDK_CMDLINE_TOOLS_PREFIX=${SDK_PREFIX}/cmdline-tools/latest/bin
SDK_BUILD_TOOLS_PREFIX=${SDK_PREFIX}/build-tools/34.0.0-rc2
SDK_PLATFORM_PREFIX=${SDK_PREFIX}/platforms/android-29

SDK_BASE_PACKAGE=${SDK_PLATFORM_PREFIX}/android.jar
AAPT2=${SDK_BUILD_TOOLS_PREFIX}/aapt2
D8=${SDK_BUILD_TOOLS_PREFIX}/d8

# Java
# I'm using 11.0.19
JAVAC=/usr/bin/javac

# Android Debug Bridge
ADB=/usr/bin/adb

# Keystore tools
KEYTOOL=/usr/bin/keytool
JARSIGNER=/usr/bin/jarsigner

# Production keystore
PROD_KEYALIAS=production
PROD_KEYSTORE=production.keystore

# Debug keystore
DEBUG_KEYALIAS=debug
DEBUG_KEYSTORE=debug.keystore
DEBUG_STOREPASS=debug_pass

# Project
AUTHOR=chris256
APP_NAME=myapp

ANDROID_MANIFEST=AndroidManifest.xml
SRC_DIR=src
RES_DIR=res
BUILD_DIR=build
APK_RES_DIR=${BUILD_DIR}/apk_res
TMP_APK=${BUILD_DIR}/build.apk
CLASS_DIR=${BUILD_DIR}/class
GEN_SRC_DIR=${BUILD_DIR}/gen_src
DEBUG_APK=${BUILD_DIR}/debug.apk

JAVA_MAIN=MainActivity
