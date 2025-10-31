package com.example.farmoish

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity(){
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
    MapKitFactory.setApiKey("7ecfa854-4486-4b75-a1b9-c3c300274d1f")
    super.configureFlutterEngine(flutterEngine)
  }
}