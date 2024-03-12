import 'package:barcode_scanner/main.dart';
import 'package:barcode_scanner/page/detector_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  CustomPaint? _customPaint;
  String? _text;
  CameraLensDirection _cameraLensDirection = CameraLensDirection.back;
  bool _isBusy = false;
  bool _canProcess = true;


  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetectorView(
        title: "바코드 스캐너 앱",
        customPaint: _customPaint,
        text: _text,
        onImage: _fncProcessImage,
        initialCameraLensDirection: _cameraLensDirection,
        initialDetectionMode: DetectorViewMode.gallery,
        onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      ),
    );
  }

  Future<void> _fncProcessImage(InputImage inputImage) async {
    setState(() {
      _text;
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (inputImage.metadata?.size != null
    && inputImage.metadata?.rotation != null) {

    } else {
      String text = "바코드 탐색 : ${barcodes.length}개 \n";

      for (var barcode in barcodes) {
        text += "바코드 값 : ${barcode.rawValue}\n";
        text += "boundingBox : ${barcode.boundingBox}\n";
        text += "format : ${barcode.format}\n";
        text += "type : ${barcode.type}\n";
      }

      setState(() {
        _text = text;
      });


    }
  }
}
