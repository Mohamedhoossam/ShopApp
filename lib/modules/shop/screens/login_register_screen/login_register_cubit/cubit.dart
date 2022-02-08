

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_layout.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_register_cubit/states.dart';
import 'package:myshop/model/userdata.dart';
import 'package:myshop/network/local/local.dart';
import 'package:myshop/network/remote/remote.dart';
import 'package:myshop/shared/constant/constant.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(LoginInitialStates());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  IconData eye=Icons.visibility_off;
  bool isPassword=true;
  void changePassword(){

    isPassword=!isPassword;
    isPassword?eye=Icons.visibility_off:eye=Icons.visibility;
    emit(LoginChangeStates());

  }

  // post data from json api

 late UserProfileData userProfileData;
  void postData(
      {
        required String email,
        required String password,
        required BuildContext context,

      }
      ){
    emit(LoginLoadingStates());
    DioHelper.postData(url: 'login', data: {
      'email':email,
      'password':password,

    }).then((value) {

      userProfileData=UserProfileData.fromJson(value.data);
      token=userProfileData.data!.token;
      CacheHelper.saveData(key: 'token', value: userProfileData.data!.token);
      print(userProfileData.message.toString());
      if(userProfileData.status){
        CacheHelper.saveData(key: 'name', value: userProfileData.data!.name);
        CacheHelper.saveData(key: 'email', value: userProfileData.data!.email);
        CacheHelper.saveData(key: 'phone', value: userProfileData.data!.phone);
        userName = CacheHelper.getData(key: 'name');
        myEmail = CacheHelper.getData(key: 'email');
        // userName=userProfileData.data!.name;
        // myEmail=userProfileData.data!.email;
        navigateToAndRemove(context,  const ShopLayout());
      Fluttertoast.showToast(
                msg: userProfileData.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 14.0
            );


        emit(LoginSuccessStates(userProfileData.data!));

      }
      else{
        Fluttertoast.showToast(
            msg: userProfileData.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0
        );
        emit(LoginErrorStates());
      }
      ShopCubit.get(context).getData();
      ShopCubit.get(context).getFavoriteData();
      ShopCubit.get(context).getCategoriesData();


    }).catchError((error){
      print(error.toString());
      emit(LoginErrorStates());
    });
  }






}