import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey("7ecfa854-4486-4b75-a1b9-c3c300274d1f") // Your generated API key
  }
}