import 'package:flutter/cupertino.dart';

class ImageRecognitionResult {
  Result result;
  Status status;

  ImageRecognitionResult({this.result, this.status});

  ImageRecognitionResult.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }

  String providedResults(){
    String res = "";
    int count = 1;
    for (Tags tag in result.tags){
      res += tag.tag.en;
      if (count>2)
        break;
      res+=', ';
      count++;
    }
    return res;
  }
}

class Result {
  List<Tags> tags;

  Result({this.tags});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  double confidence;
  Tag tag;

  Tags({this.confidence, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'];
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confidence'] = this.confidence;
    if (this.tag != null) {
      data['tag'] = this.tag.toJson();
    }
    return data;
  }
}

class Tag {
  String en;

  Tag({this.en});

  Tag.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}

class Status {
  String text;
  String type;

  Status({this.text, this.type});

  Status.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}
