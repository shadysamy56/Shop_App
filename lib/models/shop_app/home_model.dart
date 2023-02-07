// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShopHomeModel {
  bool? status;
  HomeDataModel? data;

  ShopHomeModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    //data = HomeDataModel.fromJson(json['data']);
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  late List<BannerModel> banners;
  late List<ProductModel> products;
  // HomeDataModel(
  //    this.banners,
  //    this.products,
  // );

  HomeDataModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners.add(BannerModel.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
