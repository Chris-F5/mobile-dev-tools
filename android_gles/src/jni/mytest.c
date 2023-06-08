#include <jni.h>

#include <GLES/gl.h>
#include <GLES/egl.h>

static int window_width = 320;
static int window_height = 480;
static int paused = 0;


void
Java_com_chris256_myapp_MyGLSurfaceView_nativePause(JNIEnv* env)
{
  paused = 1;
}

void
Java_com_chris256_myapp_MyGLSurfaceView_nativeResume(JNIEnv* env)
{
  paused = 0;
}

void
Java_com_chris256_myapp_MyGLSurfaceView_nativeTogglePauseResume(
    JNIEnv* env)
{
  paused = !paused;
}

void
Java_com_chris256_myapp_MyRenderer_nativeInit(JNIEnv* env)
{
  glEnable(GL_NORMALIZE);
  glEnable(GL_DEPTH_TEST);
  glDisable(GL_CULL_FACE);
  glShadeModel(GL_FLAT);

  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_LIGHT1);
  glEnable(GL_LIGHT2);

  glEnableClientState(GL_VERTEX_ARRAY);
  glEnableClientState(GL_COLOR_ARRAY);
}

void
Java_com_chris256_myapp_MyRenderer_nativeResize(JNIEnv* env,
    jobject this, jint w, jint h)
{
  window_width = w;
  window_height = h;
}

void
Java_com_chris256_myapp_MyRenderer_nativeRender(
    JNIEnv* env)
{
  glClearColorx((GLfixed)(0.1f * 65536), (GLfixed)(0.2f * 65536),
                (GLfixed)(0.3f * 65536), 0x10000);
  glClear(GL_COLOR_BUFFER_BIT);
}
