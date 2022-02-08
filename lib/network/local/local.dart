import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CacheHelper{
  static late  SharedPreferences sharedPreferences;

static init() async{

  sharedPreferences=await SharedPreferences.getInstance();
}

  static Future<bool> saveData({
    required String key,
    required dynamic value,


  })async{

    if(value is bool) {return await sharedPreferences.setBool(key, value);}
    else if(value is int){ return await sharedPreferences.setInt(key, value);}
    else if(value is String) {return await sharedPreferences.setString(key, value);}
    else{return await sharedPreferences.setDouble(key, value);}


  }


static dynamic getData({
  required String key,
}){

  return sharedPreferences.get(key);


}


  static dynamic remove({
    required String key,
    required context,
  }){

    return sharedPreferences.remove(key).then((value) {
      navigateToAndRemove(context, LoginScreen());
    });


  }


}

