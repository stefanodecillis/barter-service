class Intersection {
  String title;
  String description;
  String imgUrl;

  Intersection({this.title, this.description, this.imgUrl});

  Intersection.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
