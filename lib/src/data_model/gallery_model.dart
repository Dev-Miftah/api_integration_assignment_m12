class GalleryModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  GalleryModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
