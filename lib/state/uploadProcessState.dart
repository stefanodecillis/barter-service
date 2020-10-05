import 'dart:io';

class UploadProcessState {
  UploadProcessState._();

  File image;
  String title;
  String description;

  factory UploadProcessState.initial() {
    return UploadProcessState._()
      ..description = ""
      ..title = "";
  }
}
