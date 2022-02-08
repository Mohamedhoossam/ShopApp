import 'package:flutter/material.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/network/local/local.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile", style: TextStyle(),) ,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,


            children:    [
              const SizedBox(height: 60,),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/login1.png',),
                radius: 40.0,
              ),
              const SizedBox(height: 20,),
              DefultTextFormFiled(
                hintText: '${CacheHelper.getData(key: 'name')}',
                prefix: Icons.person,
                lockKeyboard: true,
                labelColor: Colors.black,
                prefixColors: Colors.blue
              ),
              const SizedBox(height: 15,),
              DefultTextFormFiled(
                hintText: '${CacheHelper.getData(key: 'email')}',
                prefix: Icons.email,
                lockKeyboard: true,
                labelFontSize: 14,
                labelColor: Colors.black,
                prefixColors: Colors.blue,



              ),
              const SizedBox(height: 15,),
              DefultTextFormFiled(
                hintText: '${CacheHelper.getData(key: 'phone')}',
                prefix: Icons.phone_android,
                lockKeyboard: true,
                labelFontSize: 14,
                labelColor: Colors.black,
                prefixColors: Colors.blue,



              ),

            ],
          ),
        ),
      ),
    );
  }
}
