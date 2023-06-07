include config.mk

JAVA_SRC:=$(shell find ${SRC_DIR}/java -type f -name "*.java")
RES:=$(shell find ${RES_DIR} -type f)

${BUILD_DIR}/debug.apk: AndroidManifest.xml ${JAVA_SRC} ${DEBUG_KEYSTORE} ${APK_RES_DIR}
	mkdir -p ${BUILD_DIR}
	${AAPT2} link -I ${SDK_BASE_PACKAGE} -o ${TMP_APK} \
		--manifest ${ANDROID_MANIFEST} --java ${GEN_SRC_DIR} \
		${APK_RES_DIR}/layout_activity_main.xml.flat
	${JAVAC} -classpath ${SRC_DIR}/java:${GEN_SRC_DIR}:${SDK_BASE_PACKAGE} \
		-d ${CLASS_DIR} ${SRC_DIR}/java/com/${AUTHOR}/${APP_NAME}/${JAVA_MAIN}.java
	${D8} --output ${BUILD_DIR} ${CLASS_DIR}/com/${AUTHOR}/${APP_NAME}/${JAVA_MAIN}.class
	zip -j -u ${TMP_APK} ${BUILD_DIR}/classes.dex
	${JARSIGNER} -verbose -keystore ${DEBUG_KEYSTORE} \
		-storepass ${DEBUG_STOREPASS} ${TMP_APK} ${DEBUG_KEYALIAS}
	mv --force ${TMP_APK} $@

${APK_RES_DIR}: ${RES}
	mkdir -p ${APK_RES_DIR}
	${AAPT2} compile --dir ${RES_DIR} -o ${APK_RES_DIR}

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
