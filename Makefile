include config.mk

${BUILD_DIR}/debug.apk: AndroidManifest.xml res ${DEBUG_KEYSTORE} ${src} ${APK_RES}
	mkdir -p ${BUILD_DIR}
	${AAPT2} link -I ${SDK_BASE_PACKAGE} -o ${TMP_APK} \
		--manifest ${ANDROID_MANIFEST} --java ${GEN_SRC} \
		${APK_RES}/*
	${JAVAC} -sourcepath ${SRC} -classpath ${GEN_SRC}:${SDK_BASE_PACKAGE} \
		-d ${CLASS_DIR} ${SRC}/com/${AUTHOR}/${APP_NAME}/${JAVA_MAIN}.java
	${D8} --output ${BUILD_DIR} ${CLASS_DIR}/com/${AUTHOR}/${APP_NAME}/${JAVA_MAIN}.class
	zip -j -u ${TMP_APK} ${BUILD_DIR}/classes.dex
	${JARSIGNER} -verbose -keystore ${DEBUG_KEYSTORE} \
		-storepass ${DEBUG_STOREPASS} ${TMP_APK} ${DEBUG_KEYALIAS}
	mv --force ${TMP_APK} $@

${APK_RES}: ${RES}
	mkdir -p ${APK_RES}
	aapt2 compile --dir ${RES} -o ${APK_RES}

${DEBUG_KEYSTORE}:
	${KEYTOOL} -genkeypair \
		-keystore ${DEBUG_KEYSTORE} \
		-alias ${DEBUG_KEYALIAS} \
		-storepass ${DEBUG_STOREPASS} \
		-validity 3650 \
		-dname "CN=debug"

${PROD_KEYSTORE}:
	${KEYTOOL} -genkeypair \
		-keystore ${PROD_KEYSTORE} \
		-alias ${PROD_KEYALIAS} \
		-validity 365

.PHONY: install clean

install: ${DEBUG_APK}
	${ADB} install $<

clean:
	rm -fr ${BUILD_DIR}
