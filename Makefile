include config.mk

debug.apk: AndroidManifest.xml res classes.dex ${DEBUG_KEYSTORE}
	${AAPT} package -f -M AndroidManifest.xml -S res -I ${SDK_BASE_PACKAGE} -F $@
	${AAPT} add $@ classes.dex || rm -f $@
	${JARSIGNER} -verbose -keystore ${DEBUG_KEYSTORE} \
		-storepass ${DEBUG_STOREPASS} $@ ${DEBUG_KEYALIAS} || rm -f $@

classes.dex: src/MainActivity.class
	${D8} --output . src/MainActivity.class

src/MainActivity.class: src/MainActivity.java
	${JAVAC} -cp src:${SDK_BASE_PACKAGE} src/MainActivity.java

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

install: debug.apk
	${ADB} install $<

clean:
	rm -f debug.apk src/MainActivity.class classes.dex
