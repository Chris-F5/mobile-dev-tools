include config.mk

app.apk: AndroidManifest.xml res classes.dex ${KEYSTORE}
	${AAPT} package -f -M AndroidManifest.xml -S res -I ${SDK_BASE_PACKAGE} -F $@
	${AAPT} add app.apk classes.dex || rm -f $@
	${JARSIGNER} -verbose -keystore ${KEYSTORE} app.apk mykey || rm -f $@

classes.dex: src/MainActivity.class
	${D8} --output . src/MainActivity.class

src/MainActivity.class: src/MainActivity.java
	${JAVAC} -cp src:${SDK_BASE_PACKAGE} src/MainActivity.java

${KEYSTORE}:
	${KEYTOOL} -genkeypair -alias ${KEYALIAS} -keystore ${KEYSTORE}

.PHONY: install clean

install: app.apk
	${ADB} install app.apk

clean:
	rm -f app.apk src/MainActivity.class classes.dex

