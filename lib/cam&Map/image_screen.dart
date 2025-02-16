import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imge Picker'),
      ),
      body: images == null
          ? SizedBox()
          : Image(image: FileImage(File(images!.path.toString()))),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              openCameraAndGallary(source: ImageSource.camera);
            },
            child: Icon(Icons.camera_alt),
          ),
          FloatingActionButton.small(
            onPressed: () {
              openCameraAndGallary();
            },
            child: Icon(Icons.image),
          )
        ],
      ),
    );
  }

  void openCameraAndGallary({ImageSource source = ImageSource.gallery}) async {
    var data = await ImagePicker().pickImage(source: source);
    setState(() {
      images = File(data!.path);
    });
  }
}
