import 'dart:io';

import 'package:barter/entity/imageRecognitionResult.dart';

class UploadProcessState {
  UploadProcessState._();

  File image;
  String title;
  String description;
  ImageRecognitionResult imageRecognitionResult;

  factory UploadProcessState.initial() {
    return UploadProcessState._()
      ..description = ""
      ..title = ""
    ..imageRecognitionResult=null;
  }
}
