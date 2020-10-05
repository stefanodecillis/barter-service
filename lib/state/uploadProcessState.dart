import 'dart:io';

class UploadProcessState {
  UploadProcessState._();

  File image;

  factory UploadProcessState.initial() {
    return UploadProcessState._();
  }
}
