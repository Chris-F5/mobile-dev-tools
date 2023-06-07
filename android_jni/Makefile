JAVA_SRC:=$(shell find src/java -type f -name "*.java")
NDK_CC=armv7a-linux-androideabi29-clang
SDK_JAR=/opt/android-sdk/platforms/android-29/android.jar

build/app.apk: AndroidManifest.xml debug.keystore build/apk/lib/armeabi-v7a/libmytest.so \
	build/res/layout_activity_main.xml.flat ${JAVA_SRC}
	mkdir -p build/{src,apk,class}
	aapt2 link -I ${SDK_JAR} --manifest AndroidManifest.xml --java build/src \
		--output-to-dir -o build/apk \
		build/res/layout_activity_main.xml.flat
	javac -classpath src/java:build/src:${SDK_JAR} -d build/class \
		src/java/com/chris256/myapp/MainActivity.java
	d8 --output build/apk build/class/com/chris256/myapp/MainActivity.class
	(cd build/apk && zip -r -D ../app.apk . )
	jarsigner -keystore debug.keystore -storepass debug_password build/app.apk debug

build/apk/lib/armeabi-v7a/libmytest.so: build/obj/mytest.o
	mkdir -p $(shell dirname $@)
	${NDK_CC} --shared -o $@ $^

build/obj/mytest.o: src/jni/mytest.c
	mkdir -p $(shell dirname $@)
	${NDK_CC} -c $< -o $@ -fPIC

build/res/layout_activity_main.xml.flat: res/layout/activity_main.xml
	mkdir -p build/res
	aapt2 compile res/layout/activity_main.xml -o build/res

debug.keystore:
	keytool -genkeypair \
		-keystore debug.keystore \
		-alias debug \
		-storepass debug_password \
		-validity 3650 \
		-dname "CN=debug"

.PHONY: install clean

install: build/app.apk
	adb install build/app.apk

clean:
	rm -fr build
