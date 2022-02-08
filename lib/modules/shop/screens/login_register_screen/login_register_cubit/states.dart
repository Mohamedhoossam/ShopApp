import 'package:myshop/model/userdata.dart';

abstract class ShopLoginStates{}
 class LoginInitialStates extends ShopLoginStates {}
 class LoginChangeStates extends ShopLoginStates {}
 class LoginLoadingStates extends ShopLoginStates {}
 class LoginSuccessStates extends ShopLoginStates {

 final UserData userData;
 LoginSuccessStates(this.userData);

 }
 class LoginErrorStates extends ShopLoginStates {}