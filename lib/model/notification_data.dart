class NotificationModel {
  bool? status;
  Null? message;
  Data1? data;
  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data1.fromJson(json['data']) : null;
  }

}
class Data1 {
  int? currentPage;
  List<Data2>? data;
  Data1.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add( Data2.fromJson(v));
      });
    }

  }


}
class Data2 {
  int? id;
  String? title;
  String? message;

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }


}
