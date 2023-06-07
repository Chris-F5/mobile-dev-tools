#include <jni.h>

JNIEXPORT jint JNICALL
Java_com_chris256_myapp_MainActivity_testFunction(JNIEnv *env, jclass clazz, jint a, jint b)
{
    return (jint)(2 * a + b);
}
