package com.chris256.myapp;

import com.chris256.myapp.R;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
  static {
    System.loadLibrary("mytest");
  }
  private static native int testFunction(int a, int b);

  @Override
  protected void onCreate(Bundle state) {
    super.onCreate(state);
    int result = MainActivity.testFunction(3, 4);
    setContentView(R.layout.activity_main);

    TextView textView = findViewById(R.id.textView);
    textView.setText(String.valueOf(result));
  }
}
