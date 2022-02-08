class HomeDataModel {
  late bool status;
  late Data data;
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data=(Data.fromJson(json['data']));
  }


}

class Data {
   List<Banners> banners=[];
   List<Products> products=[];
  late String ad;
  Data.fromJson(Map<String, dynamic> json) {

    ad = json['ad'];
    json['banners'].forEach((element){
      banners.add(Banners.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(Products.fromJson(element));
    }
    );

  }


}

class Banners {
  late int id;
  late String image;
  String? category;
  String? product;



  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }


}

class Products {
    late int id;
    late dynamic price;
    late dynamic oldPrice;
    late dynamic discount;
    late String image;
    late String name;
    late String description;
    late List images;
    late bool inFavorites;
    late bool inCart;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}
