import 'package:myshop/model/change_favorites_model.dart';

abstract class ShopStates{}
 class ShopInitialStates extends ShopStates{}
 class ShopChangeIndexStates extends ShopStates{}
 class ShopHomeDataSuccessStates extends ShopStates{}
 class ShopHomeDataErrorStates extends ShopStates{}
 class ShopHomeDataLoadingStates extends ShopStates{}
 class ShopFavoritesLoadingStates extends ShopStates{}
 class ShopFavoritesSuccessStates extends ShopStates{}
 class ShopChangeFavoritesSuccessStates extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;
  ShopChangeFavoritesSuccessStates(this.changeFavoritesModel);}
class ShopFavoritesErrorStates extends ShopStates{}
class SearchLoadingState extends ShopStates {}
class SearchSuccessState extends ShopStates {}
class SearchErrorState extends ShopStates {}
class NotificationLoadingState extends ShopStates {}
class NotificationSuccessState extends ShopStates {}
class NotificationErrorState extends ShopStates {}
class ShopLogoutLoadingState extends ShopStates {}
class ShopLogoutSuccessState extends ShopStates {}
class ShopLogoutErrorState extends ShopStates {}
class ShopCategorySuccessStates extends ShopStates{}
class ShopCategoryErrorStates extends ShopStates{}
class ShopCategoryLoadingStates extends ShopStates{}



