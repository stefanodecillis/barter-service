import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(110))),
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ], shape: BoxShape.circle, color: Colors.red),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.file_upload,
                      size: 40,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ], shape: BoxShape.circle, color: Colors.red),
                  ),
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
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
            top: 40,
            left: 20,
          )
        ],
      ),
    );
  }
}
