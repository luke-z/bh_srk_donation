import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../main.dart' as main;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'create_contribution.dart' as path;

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => new CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String imagePath;
  String filePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = new CameraController(main.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cam"),
        backgroundColor: Colors.red[900],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller)),
          ),
          _captureControlRowWidget(),
          new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cameraTogglesRowWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw new ArgumentError('Unknown lens direction');
  }

  Widget _captureControlRowWidget() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          showInSnackBar('Picture saved to $filePath');
          File recentPic = File(filePath.toString());
          //print(filePath);
          //List<int> recentPicPath = recentPic.readAsBytesSync();
          //String base64Image = base64Encode(recentPic.readAsBytesSync());
          //path.imagePath = filePath;
          //path.base64Image = base64Encode(recentPic.readAsBytesSync());
        }
      }
      Navigator.pop(context, imagePath);
    });

  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (main.cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in main.cameras) {
        toggles.add(
          new SizedBox(
            width: 90.0,
            child: new RadioListTile<CameraDescription>(
              title:
                  new Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return new Row(children: toggles);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = new CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');
}
