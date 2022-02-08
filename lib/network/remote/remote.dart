import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout:20 * 1000,  //20 seconds
        receiveTimeout: 20 * 1000,  //20 seconds

      )
    );
  }

  static Future<Response> postData({
     required String url,
     required Map<String,dynamic> data,
     Map<String,dynamic>? query,
     String? token,
})async{
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization':token??'',
    };
    return await dio.post(url,data:data ,queryParameters:query, );
    
  }


  static Future<Response> getData(

      {
        required String url,
         String? token,
        Map<String,dynamic>?query,
      }) async{

    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization':token??'',
    };
    return await dio.get(url,queryParameters:query );
  }


}