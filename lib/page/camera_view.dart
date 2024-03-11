import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';





class CameraView extends StatefulWidget {
  const CameraView({
    required this.customPaint,
    required this.onImage,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,

    super.key
  });

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {

  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  bool _changingCameraLens = false;

  final _orientations = {
    DeviceOrientation.portraitUp : 0,
    DeviceOrientation.landscapeLeft : 90,
    DeviceOrientation.portraitDown : 180,
    DeviceOrientation.landscapeRight : 270,
  };


  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }

    for (int i =0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }

    if (_cameras != -1) {
      _startLiveFeed();
    }
  }

  Future _startLiveFeed() {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888
    );

    _controller?.initialize().then((value) {
      if (!mounted) {
        return;
      }
    });

    _controller?.getMinZoomLevel().then((value) {
      _minAvailableZoom = value;
      _currentZoomLevel = value;
    });

    _controller?.getMaxZoomLevel().then((value) {
      _maxAvailableZoom = value;
    });

    _controller?.startImageStream(_processCameraImage).then((value) {
      if (widget.onCameraFeedReady != null) {
        widget.onCameraFeedReady!();
      }
      if (widget.onCameraLensDirectionChanged != null) {
        widget.onCameraLensDirectionChanged!(camera.lensDirection);
      }
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  
}
