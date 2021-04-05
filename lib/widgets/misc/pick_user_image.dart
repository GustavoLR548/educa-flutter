import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickUserImage extends StatefulWidget {
  final void Function(File pickedImage) sendImageData;
  PickUserImage(this.sendImageData);

  @override
  _PickUserImageState createState() => _PickUserImageState();
}

class _PickUserImageState extends State<PickUserImage> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxHeight: 150,
        maxWidth: 150);
    if (pickedImage == null) return;
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.sendImageData(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage == null
            ? AssetImage('assets/images/icon.jpg')
            : FileImage(_pickedImage),
      ),
      TextButton(
        onPressed: _pickImage,
        child: Icon(Icons.image),
      )
    ]);
  }
}
