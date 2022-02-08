import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/notification_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
           // backgroundColor: Colors.blue,
            title: const Text('Notification!'),
          ),
          body: ListView.separated(
              itemBuilder: (context,index)=> notificationBuilder(cubit.notificationModel.data!.data![index]),
              separatorBuilder:(context,index)=> separator(),
              itemCount:cubit.notificationModel.data!.data!.length ),
        );
      },
    );
  }
  Widget notificationBuilder(Data2 model)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(

      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),

      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
            Text("${model.title}",
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Jannah',
              ),
            ),
          ],
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("${model.message}",
                     style: const TextStyle(
                       fontSize: 12,
                       fontFamily: 'Jannah',
                         color: Colors.red
                     ),
                    maxLines: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
