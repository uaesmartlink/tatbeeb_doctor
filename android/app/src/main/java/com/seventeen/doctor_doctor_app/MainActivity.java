package com.seventeen.doctor_doctor_app;

import android.content.Context;
import androidx.multidex.MultiDex;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
public class MainActivity extends FlutterActivity {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
