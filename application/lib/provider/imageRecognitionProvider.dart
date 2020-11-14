import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:barter/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ImageRecognitionProvider {

  final successCode = 200;
  final String url = 'https://api.imagga.com/v2/tags"';

  imageRecognition(File image) async {

    List<int> bytes = utf8.encode(apiKey+':'+apiSecret);
    String auth = base64Encode(bytes);

    auth = "Basic " + auth;

    debugPrint(auth);


    FormData formData = new FormData.fromMap({
      "image": MultipartFile.fromFile(image.path, filename:"image.jpg")
    });

    Response response = await Dio().post(url, options: Options(
      headers: {
       "Authentication": auth, //YWNjXzY5NDFjMjg1NWU0NGE2NDoyZWRiMTI4Mzc1ZDA0ZjEwODZhNjRkOWQ5YTAzNDkwOQ==
      },
      extra: {
        "image": MultipartFile.fromFile(image.path, filename:"image.jpg")
      }
    ),);

    /*Uint8List _bytesData =
    Base64Decoder().convert(image.toString().split(",").last);
    List<int> _selectedFile = _bytesData;*/

   /* var request = http.MultipartRequest(
        "POST", Uri.parse(url));
    request.files.add(http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "text_upload.txt"));
    request.headers.set('content-type', 'application/json');
    var multipartFile = await http.MultipartFile.fromPath(
        "photo", image.path,
        contentType: MediaType('image', 'jpeg'));
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    var responseByteArray = await response.stream.toBytes();

    return ImageUploadModel.fromJson(
        json.decode(utf8.decode(responseByteArray)));*/

   /* var response = await http.post(url, headers: {"Authorization": auth}, body: image.);*/
    debugPrint(response.statusCode.toString());
    debugPrint(response.statusMessage);
  }

}