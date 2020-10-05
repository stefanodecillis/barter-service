import 'dart:io';

abstract class UploadProcessEvent {}

class UploadPicture extends UploadProcessEvent {
  File image;
  UploadPicture(this.image);
}
