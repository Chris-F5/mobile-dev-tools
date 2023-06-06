package com.chris256.myapp;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
  private static final int LAYOUT_ACTIVITY_MAIN = 0x7f020000;

  @Override
  protected void onCreate(Bundle state) {
    super.onCreate(state);
    setContentView(LAYOUT_ACTIVITY_MAIN);
  }
}
