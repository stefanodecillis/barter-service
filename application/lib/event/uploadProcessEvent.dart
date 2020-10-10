import 'dart:io';

abstract class UploadProcessEvent {}

class UploadPicture extends UploadProcessEvent {
  File image;
  UploadPicture(this.image);
}

class UploadPost extends UploadProcessEvent {
  final String title;
  final String description;

  UploadPost({this.title, this.description});
}
