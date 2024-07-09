import 'dart:io';
import 'package:camera/camera.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {super.key,
      required this.title,
      this.customPaint,
      this.text,
      required this.onImage,
      required this.initialDirection});

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController cameraController;
  File? image;
  String? path;
  int cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  final allowPicker = false;
  bool changingCameraLens = false;

  @override
  void initState() {
    super.initState();
    if (cameras.any((element) =>
        element.lensDirection == widget.initialDirection &&
        element.sensorOrientation == 90)) {
      cameraIndex = cameras.indexOf(cameras.firstWhere((element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90));
    } else {
      cameraIndex = cameras.indexOf(cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection));
    }
    startLive();
  }

  @override
  void dispose() {
    stopLive();
    super.dispose();
  }

  Future startLive() async {
    final camera = cameras[cameraIndex];
    cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      cameraController.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });

      cameraController.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });

      cameraController.startImageStream(processCameraStream);
      setState(() {});
    });
  }

  Future processCameraStream(final CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final inputImageMetaData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes[0].bytesPerRow);

    final inputImage =
        InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);
    widget.onImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Future stopLive() async {
    await cameraController.stopImageStream();
    await cameraController.dispose();
  }

  Widget _buildBody() {
    if (cameraController.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.sizeOf(context);
    var scale = size.aspectRatio * cameraController.value.aspectRatio;

    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: scale,
            child: Center(
              child: changingCameraLens
                  ? const Text("Changing camera lens")
                  : CameraPreview(cameraController),
            ),
          ),
          widget.customPaint ?? const SizedBox(),
          Positioned(
              bottom: 100,
              left: 50,
              right: 50,
              child: Slider(
                value: zoomLevel,
                min: minZoomLevel,
                max: maxZoomLevel,
                onChanged: (value) {
                  setState(() {
                    zoomLevel = value;
                    cameraController.setZoomLevel(zoomLevel);
                  });
                },
                divisions: (maxZoomLevel - 1).toInt() < 1
                    ? null
                    : (maxZoomLevel - 1).toInt(),
              )),
        ],
      ),
    );
  }
}
