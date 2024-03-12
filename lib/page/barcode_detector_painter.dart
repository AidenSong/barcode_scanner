



import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter({
    this.barcodes,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  });

  final List<Barcode>? barcodes;
  final Size? imageSize;
  final InputImageRotation? rotation;
  final CameraLensDirection? cameraLensDirection;


  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.red;

    final Paint background = Paint() ..color = Colors.black;
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize
        || oldDelegate.barcodes != barcodes;
  }
}