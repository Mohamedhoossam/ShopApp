import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/category_data_model.dart';
import 'package:myshop/model/change_favorites_model.dart';
import 'package:myshop/model/favorites_data_model.dart';
import 'package:myshop/model/home_data_model.dart';
import 'package:myshop/model/notification_data.dart';
import 'package:myshop/model/search_data_model.dart';
import 'package:myshop/modules/shop/screens/category_screen.dart';
import 'package:myshop/modules/shop/screens/favorites_screen.dart';
import 'package:myshop/modules/shop/screens/home_screen.dart';
import 'package:myshop/network/local/local.dart';
import 'package:myshop/network/remote/remote.dart';
import 'package:myshop/shared/constant/constant.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(ShopInitialStates());
  static ShopCubit get(context)=>BlocProvider.of(context);
  var currentIndex = 0;
  var xy=0;
  String? im ;
  Color color= Colors.grey;
  bool isColor = false;

  void changeImage(String myImage){
   im=myImage;
   emit(ShopChangeIndexStates());
  }

  void changeColor(){
    isColor = ! isColor;
    isColor ? color = Colors.red :color = Colors.grey;

    emit(ShopChangeIndexStates());
  }


  void changeIndex12(index){

    xy=index;
    emit(ShopChangeIndexStates());
    }

  List<Widget> screen=[
    HomeScreen(),
   const FavoritesScreen(),
    const CategoriesScreen(),

  ];


  void changeIndex({index ,required context}){
    currentIndex=index;
    emit(ShopChangeIndexStates());
  }


   HomeDataModel? homeDataModel;
  Map<int,bool> isFavorites={};
  void getData()async{
    emit(ShopHomeDataLoadingStates());
    DioHelper.getData(url:'home',token:token).then((value) {

      homeDataModel=HomeDataModel.fromJson(value.data!);
      homeDataModel!.data.products.forEach((element) {
        isFavorites.addAll(
          {
            element.id:element.inFavorites
          }
        );
      });
      emit(ShopHomeDataSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorStates());
    });


  }


  late GetFavoritesModel getFavoritesModel;
  void getFavoriteData(){
    emit(ShopFavoritesLoadingStates());
    DioHelper.getData(url: 'favorites',token:token).then((value) {
      getFavoritesModel=GetFavoritesModel.fromJson(value.data!);
      emit(ShopFavoritesSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopFavoritesErrorStates());
    });


  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavoritesItems(productId){
    isFavorites[productId]==true? isFavorites[productId]=false :isFavorites[productId]= true;
    emit(ShopFavoritesSuccessStates());
    DioHelper.postData(
        url: 'favorites',
        data: {
      'product_id' : productId},
        token: token
    ).then((value) {
      changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
      emit(ShopChangeFavoritesSuccessStates(changeFavoritesModel!));
      if(changeFavoritesModel!.status==false){
        isFavorites[productId]==true? isFavorites[productId]=false :isFavorites[productId]= true;
      }
      else{
        getFavoriteData();
      }
    }
    ).catchError((error){
      isFavorites[productId]==true? isFavorites[productId]=false :isFavorites[productId]= true;
      print(error);
      emit(ShopFavoritesErrorStates());
    });
  }
  

  late CategoriesModel categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(url: 'categories',token:token).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data!);
      emit(ShopFavoritesSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopFavoritesErrorStates());
    });


  }

  
  late SearchModel searchModel ;
  void search(String text)async{

    emit(SearchLoadingState());
   await DioHelper.postData(
        url: "products/search",
        data: {
          'text':text,
        },
        token: token
    ).then((value) {
      print(value.data.toString());
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  late NotificationModel notificationModel;
  var notificationNumber = 0;
  void getNotificationData()async{
    emit(NotificationLoadingState());
    DioHelper.getData(url:'notifications',token: token).then((value) {
     notificationModel=NotificationModel.fromJson(value.data);
     notificationNumber=notificationModel.data!.data!.length;
     emit(NotificationSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NotificationErrorState());
   });
  }

  void shopLogout(context)async{
    emit(ShopLogoutLoadingState());
    DioHelper.postData(url: 'logout',
        data: {
      'fcm_token':token
    },
        token: token).
    then((value) {
      toast(msg: "Logout done successfully", color: Colors.green);
        CacheHelper.remove(key: 'token',context: context);
        homeDataModel=null;
      emit(ShopLogoutSuccessState());
    }).catchError((error){
      toast(msg: "Logout error!", color: Colors.green);
      print(error.toString());
      emit(ShopLogoutErrorState());
    });
  }


}