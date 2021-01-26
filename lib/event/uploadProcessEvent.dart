import 'dart:io';

import 'package:barter/entity/post.dart';

abstract class UploadProcessEvent {}

class UploadPicture extends UploadProcessEvent {
  File image;
  UploadPicture(this.image);
}

class UploadPost extends UploadProcessEvent {
  final Post post;

  UploadPost({this.post});
}
