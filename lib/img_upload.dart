import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const infinity = 1.0 / 0.0;

class ImgUpload extends StatefulWidget {
  ImgUpload({Key key}) : super(key: key);

  @override
  _ImgUploadState createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {

/* this is the function that handles getting the image from the device
*/
  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: infinity,
      child: FlatButton(
        child: Icon(
          Icons.camera_alt,
          color: Colors.redAccent,
        ),
        onPressed: this._getImage,
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 20.0),
    );
  }

}
