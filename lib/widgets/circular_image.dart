import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircularImageWidget extends StatefulWidget {
  final Function(File image) onImageChanged;

  const CircularImageWidget({Key key, @required this.onImageChanged})
      : super(key: key);
  @override
  _CircularImageWidgetState createState() => _CircularImageWidgetState();
}

class _CircularImageWidgetState extends State<CircularImageWidget> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        child: _image == null
            ? Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 65,
              )
            : Image.file(_image),
      ),
      onTap: () {
        getImage();
      },
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageChanged(File(pickedFile.path));
    }
  }
}
