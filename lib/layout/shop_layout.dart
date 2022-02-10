import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/modules/shop/screens/notfication_screen.dart';
import 'package:myshop/modules/shop/screens/profile.dart';
import 'package:myshop/network/local/local.dart';
import 'package:myshop/shared/style/icon_broken.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit=ShopCubit.get(context);
        Widget drawer1=Drawer(

          child: ListView(

            padding: EdgeInsets.zero,

            children:  [
              UserAccountsDrawerHeader(accountName: Text(CacheHelper.getData(key: 'name')),
                accountEmail: Text(CacheHelper.getData(key: 'email')),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg.png',),
                        fit: BoxFit.cover
                    )
                ),
                currentAccountPicture: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/login1.png',),

                ),



              ),
              ListTile(
                leading: const Icon(IconBroken.Profile),
                title: const Text('profile',),
                onTap:() {
                  navigateTo(context, const ProfileScreen());
                },
              ),
              const Divider(
                color: Colors.black26,
                height: .2,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(IconBroken.Plus),
                title: const Text('about us'),
                onTap:() {},
              ),
              const Divider(
                color: Colors.black26,
                height: .2,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(IconBroken.Buy),
                title: const Text('cart'),
                onTap:() {},
              ),
              const Divider(
                color: Colors.black26,
                height: .2,
                thickness: 1,
              ),
             // const SizedBox(height: 323,),
              ListTile(
                leading: const Icon(IconBroken.Logout),
                title: const Text('sign out'),
                onTap:() {
                  // CacheHelper.remove(key: 'token',context: context);
                  // cubit.homeDataModel=null;
                  cubit.shopLogout(context);
                },
                tileColor: Colors.blue,
              ),
              const SizedBox(height: 250,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Divider(
                    color: Colors.black26,
                    height: .2,
                    thickness: 1,
                  ),
                  const SizedBox(height: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("©copyright  2022 "),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  const Divider(
                    color: Colors.black26,
                    height: .2,
                    thickness: 1,
                  ),
                ],
              ),
            ],
          ),
        );
        return Scaffold(
           drawer: drawer1,
           appBar: AppBar(
             title: const Text('ShOp',style: TextStyle(fontStyle:FontStyle.italic,fontFamily: 'Jannah' ),),
             actions: [
              Stack(alignment: AlignmentDirectional.topStart,
                children: [
                IconButton(onPressed: (){
                  navigateTo(context, const NotificationScreen());
                }, icon: const Icon(IconBroken.Notification)),
                 Text("${cubit.notificationNumber==0?"":cubit.notificationNumber}",style: const TextStyle(fontStyle:FontStyle.italic,fontFamily: 'Jannah' ,color: Colors.red,fontSize: 10),)
              ],)
             ],

           ),
           backgroundColor: Colors.white,
            body:

           OfflineBuilder(
              connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                  ) {
                final bool connected = connectivity != ConnectivityResult.none;

                if(connected){
                  //print('connected ......................................');

                  return Padding(


                    padding: const EdgeInsets.only(top: 2.0),
                    child: //cubit.screen[cubit.currentIndex],

                    IndexedStack(
                      index: cubit.currentIndex,
                      children: cubit.screen,

                    ),
                  );
                }
                else{
                  return SafeArea(child: buildNoInternetWidget(context));
                }
              },
              child:const ShopLayout()
          ),
           bottomNavigationBar: BottomNavigationBar(

            items: const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Heart),label: 'favorite'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Category),label: 'category'),

            ],
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(context: context,index: index);
            },


          ),
        );
      },

    );
  }

  Widget buildNoInternetWidget(context){
    // ShopCubit.get(context).getData();
    // ShopCubit.get(context).getFavoriteData();
    // ShopCubit.get(context).getCategoriesData();
    return Center(
      child:
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off,size: 100,color: Colors.grey,),
            SizedBox(height: 20,),
            Text('Can\'t connect .. check internet',style: TextStyle(
                fontSize:  15,
                color: Colors.grey,
            ),
            ),
            SizedBox(height: 40,),

            // Center(child: CircularProgressIndicator(
            //   color: Colors.blue,
            //
            //
            // ),),
          ],
        ),
      ),
    );

  }
}



