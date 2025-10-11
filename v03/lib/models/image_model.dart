class Image {
   String? url;

  Image({this.url});

  factory Image.fromJson(Map<String, dynamic>? json) {
    return Image(url: json?['url']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }
}