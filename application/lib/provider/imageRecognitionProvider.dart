import 'dart:convert';
import 'dart:io';
import 'package:barter/constants.dart';
import 'package:barter/entity/imageRecognitionResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ImageRecognitionProvider {

  final successCode = 200;
  final String url = 'https://api.imagga.com/v2/tags';

  Future<ImageRecognitionResult> imageRecognition(File image) async {

    List<int> bytes = utf8.encode(apiKey+':'+apiSecret);
    String auth = base64Encode(bytes);

    auth = "Basic " + auth;

    debugPrint(auth);

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]);

    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    final file = await http.MultipartFile.fromPath('image', image.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    //imageUploadRequest.fields['image_base64'] = base64Image;
    imageUploadRequest.headers['Authorization'] = auth;
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await  http.Response.fromStream(streamedResponse);
      debugPrint(response.statusCode.toString()); //todo if != from 200, do something else
      debugPrint(response.body);
      ImageRecognitionResult result = ImageRecognitionResult.fromJson(jsonDecode(response.body));
      return result;
    } catch (e) {
      debugPrint(e);
    }
  }

}