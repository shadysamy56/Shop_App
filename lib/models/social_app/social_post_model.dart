// ignore_for_file: public_member_api_docs, sort_constructors_first

class SocialPostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String postImage;
  late String postText;

  SocialPostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.postImage,
    required this.postText,
  });

  SocialPostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    postText = json['postText'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'postText': postText,
    };
  }
}
