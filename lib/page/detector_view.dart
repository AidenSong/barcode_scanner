import 'package:barcode_scanner/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



class DetectorView extends StatefulWidget {
  const DetectorView({
    required this.title,
    required this.onImage,
    this.customPaint,
    this.initialDetectionMode = DetectorViewMode.gallery,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,


    super.key
  });

  final String title;
  final CustomPaint? customPaint;
  final DetectorViewMode initialDetectionMode;
  final Function(InputImage inputImage) onImage;
  final Function(DetectorViewMode mode)? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<DetectorView> createState() => _DetectorViewState();
}

class _DetectorViewState extends State<DetectorView> {

  late DetectorViewMode _mode;


  @override
  void initState() {

    _mode = widget.initialDetectionMode;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return switch(_mode) {
      DetectorViewMode.liveFeed =>
    }
  }

  void _onDetectorViewModeChanged() {
    if (_mode == DetectorViewMode.liveFeed) {
      _mode = DetectorViewMode.gallery;
    } else {
      _mode = DetectorViewMode.liveFeed;
    }

    if (widget.onDetectorViewModeChanged != null) {
      widget.onDetectorViewModeChanged!(_mode);
    }
    setState(() {});
  }
}
