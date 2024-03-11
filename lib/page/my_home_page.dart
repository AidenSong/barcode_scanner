import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CustomPaint? _customPaint;
  String? _text;
  CameraLensDirection _cameraLensDirection = CameraLensDirection.back;
  bool _isBusy = false;
  bool _canProcess = true;


  @override
  void dispose() {
    _canProcess = false;


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
