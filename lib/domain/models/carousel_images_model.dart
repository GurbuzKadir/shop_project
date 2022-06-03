class CarouselImages {
  int id;
  String imageUrl;
  String title;
  int type;

  CarouselImages({this.id, this.imageUrl, this.title, this.type});

  CarouselImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
