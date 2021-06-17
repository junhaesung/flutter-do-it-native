import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NativeApp();
  }
}

class _NativeApp extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  String _deviceInfo = 'Unknown device';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native 통신 예제'),
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _getDeviceInfo().then((value) => _deviceInfo = value);
          });
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<String> _getDeviceInfo() async {
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      return 'Device info : $result';
    } on PlatformException catch (e) {
      return 'Failed to get Device info: ${e.message}.';
    }
  }
}