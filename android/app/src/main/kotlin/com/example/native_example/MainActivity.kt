package com.example.native_example

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.flutter.dev/info"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "getDeviceInfo" -> {
                            val deviceInfo = getDeviceInfo()
                            result.success(deviceInfo)
                        }
                    }
                }
    }

    private fun getDeviceInfo(): String {
        return listOf<String>(
                Build.DEVICE,
                Build.BRAND,
                Build.MODEL
        ).joinToString(separator = "\n")
    }
}
