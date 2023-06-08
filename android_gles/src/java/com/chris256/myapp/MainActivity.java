package com.chris256.myapp;

/* import com.chris256.myapp.R; */

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.app.Activity;
import android.content.Context;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.MotionEvent;

class MyRenderer implements GLSurfaceView.Renderer {
  private static native void nativeInit();
  private static native void nativeResize(int w, int h);
  private static native void nativeRender();

  public void onSurfaceCreated(GL10 gl, EGLConfig config) {
    nativeInit();
  }

  public void onSurfaceChanged(GL10 gl, int w, int h) {
    nativeResize(w, h);
  }

  public void onDrawFrame(GL10 gl) {
    nativeRender();
  }
}

class MyGLSurfaceView extends GLSurfaceView {
  private static native void nativePause();
  private static native void nativeResume();
  private static native void nativeTogglePauseResume();

  MyRenderer renderer;

  public MyGLSurfaceView(Context context) {
    super(context);
    renderer = new MyRenderer();
    setRenderer(renderer);
  }

  public boolean onTouchEvent(final MotionEvent event) {
    if (event.getAction() == MotionEvent.ACTION_DOWN) {
      nativeTogglePauseResume();
    }
    return true;
  }

  @Override
  public void onPause() {
    super.onPause();
    nativePause();
  }

  @Override
  public void onResume() {
    super.onResume();
    nativeResume();
  }
}

public class MainActivity extends Activity {
  static {
    System.loadLibrary("mytest");
  }

  private GLSurfaceView surfaceView;

  @Override
  protected void onCreate(Bundle state) {
    super.onCreate(state);
    surfaceView = new MyGLSurfaceView(this);
    setContentView(surfaceView);
  }

  @Override
  protected void onPause() {
    super.onPause();
    surfaceView.onPause();
  }

  @Override
  protected void onResume() {
    super.onResume();
    surfaceView.onResume();
  }
}
