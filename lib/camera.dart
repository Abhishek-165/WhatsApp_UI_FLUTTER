import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class CameraScreen extends StatefulWidget {
  
  List<CameraDescription> cameras;
  CameraScreen({this.cameras});


  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

CameraController cameraController;



  @override
  void initState() {

super.initState();
    try
    {

        cameraController =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    }on CameraException catch (e) {
     print(e);
    }

  }

   void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
  @override
 Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return  Container();
    }
    return  AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child:  CameraPreview(cameraController),
    );
  }
}