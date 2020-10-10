import 'dart:io';

import 'package:barter/constants.dart';
import 'package:barter/event/uploadProcessEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/screen/uploadDataScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImgFromGallery() async {
    final pickedFile = await picker
        .getImage(source: ImageSource.gallery)
        .catchError((err) => debugPrint("no puedo"));
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        CoreLogic.instance.uploadProcessLogic.add(UploadPicture(_image));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadDataScreen()),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImgFromCamera() async {
    final pickedFile = await picker
        .getImage(source: ImageSource.camera)
        .catchError((err) => debugPrint("no puedo"));
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        CoreLogic.instance.uploadProcessLogic.add(UploadPicture(_image));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadDataScreen()),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondBg,
      body: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: mainTheme,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(110))),
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FeaturedBtn(
                    icon: Icons.add_a_photo,
                    onClick: () => getImgFromCamera(),
                  ),
                  FeaturedBtn(
                    icon: Icons.file_upload,
                    onClick: () => getImgFromGallery(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.all(1),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: mainTheme,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: secondBg),
            ),
            top: 40,
            left: 20,
          )
        ],
      ),
    );
  }
}

class FeaturedBtn extends StatelessWidget {
  FeaturedBtn({this.icon, this.onClick});
  final IconData icon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        iconSize: 40,
        onPressed: () => onClick(),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: mainBg.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        )
      ], shape: BoxShape.circle, color: mainTheme),
    );
  }
}
