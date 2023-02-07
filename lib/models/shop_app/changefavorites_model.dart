class ShopChangeFavoritesModel {
  bool? status;
  String? message;

  ShopChangeFavoritesModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
