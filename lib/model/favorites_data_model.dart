class GetFavoritesModel {
  bool? status;
  DataFav? dataFav;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataFav = json['data'] != null ? DataFav.fromJson(json['data']) : null;
  }
}

class DataFav {
  int? currentPage;
  List<DataList>? dataList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  DataFav.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      dataList = <DataList>[];
      json['data'].forEach((v) {
        dataList!.add( DataList.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class DataList {
  int? id;
  Product? product;

  DataList({this.id, this.product});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}