





import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/cubits.dart';
import 'package:myshop/network/remote/remote.dart';

import 'layout/shop_cubit/cubit/shop_cubit.dart';
import 'layout/shop_cubit/states/shop_states.dart';
import 'layout/shop_layout.dart';
import 'modules/shop/screens/login_register_screen/login_screen.dart';
import 'modules/shop/screens/login_register_screen/register_screen.dart';
import 'modules/shop/screens/onboarding.dart';
import 'network/local/local.dart';
import 'shared/constant/constant.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool onBoarding =CacheHelper.getData(key: 'onboarding') ?? false;
  token=CacheHelper.getData(key: 'token')??'';
  print(CacheHelper.getData(key: 'email'));

 late Widget widget;

  if(onBoarding){
    if(token.isNotEmpty){
      widget =  const ShopLayout();

    }else{
      widget = LoginScreen();
    }
  }else{
      widget = OnBoardingScreen();
  }


  runApp( MyApp(widget));
}


class MyApp extends StatelessWidget {


  final Widget widget;
    const MyApp(this.widget, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..getData()..getFavoriteData()..getNotificationData()..getCategoriesData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            theme: ThemeData(
                  appBarTheme:  const AppBarTheme(
                  elevation: 0.0,
                  backgroundColor:Colors.white,
                  titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
            ),
            debugShowCheckedModeBanner: false,
            home: widget,

          );
        },

      ),
    );
  }
}
