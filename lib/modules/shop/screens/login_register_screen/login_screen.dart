import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_register_cubit/cubit.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_register_cubit/states.dart';
import 'package:myshop/shared/constant/constant.dart';

class LoginScreen extends StatelessWidget {
 var formKey=GlobalKey<FormState>();
 var emailControl=TextEditingController();
 var passwordControl=TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ShopLoginCubit(),),
      ],
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state){} ,
        builder:(context,state){
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: const Text('ShopApp',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: Colors.white,
                child: Padding(


                  padding: const EdgeInsets.all(16.0),
                  child: Center(

                    child: Form(
                      key:formKey ,
                      child: SingleChildScrollView(
                        child: Column(

                          mainAxisSize: MainAxisSize.min,
                          children:  [

                            const Image(
                              image: AssetImage('assets/images/login2.png',),
                                height: 220,width: 220,

                            ),
                            const Text('Login now to can complete in the app',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 20.0,),
                            DefultTextFormFiled(
                                hintText: 'salah@gmail.com',
                                radius: 10.0,
                                prefix: Icons.email,
                                control: emailControl,
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return 'email not be Empty';
                                  }
                                  return null;
                                },
                              onsubmit: (value){


                              }
                            ),
                            const SizedBox(height: 20.0,),
                            DefultTextFormFiled(
                                hintText: 'password',
                                radius: 10.0,
                                prefix: Icons.lock,
                                suffix: cubit.eye,
                                control: passwordControl,
                                onpress: (){
                                  cubit.changePassword();
                                },

                                scure: cubit.isPassword,
                                onsubmit: (value){
                                  if(formKey.currentState!.validate()){
                                    cubit.postData(email: emailControl.text,
                                        password: passwordControl.text,
                                        context: context);
                                  }
                                },
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return 'password not be Empty';
                                  }
                                  return null;
                                }

                            ),
                            const SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: (){

                                    },
                                    child: const Text('forget password ?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0,),
                            ConditionalBuilder(
                              condition:state is! LoginLoadingStates ,
                              builder:(context)=>  Container(
                                width: 200,
                                  decoration:  BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(30),),
                                    color: defaultColor,

                                  ),
                                child: MaterialButton(
                                  onPressed: (){
                                    FocusScope.of(context).unfocus();

                                    if(formKey.currentState!.validate()){
                                      cubit.postData(email: emailControl.text,
                                          password: passwordControl.text,
                                          context: context);

                                    }
                                  },
                                  child:
                                  const Text('LOG IN',style: TextStyle(fontSize: 20.0),),


                                ),
                              ),
                              fallback:(context)=> const Center(child: CircularProgressIndicator()) ,

                            ),
                            const SizedBox(height: 40.0,),


                            // register..........................................................................
                            Row(
                              children: [
                                const Text('I Don\'t Have Account',style: TextStyle(fontSize: 14,color: Colors.grey),),
                                const Spacer(),
                                TextButton(
                                  onPressed: (){},
                                  child:  const Text('Register now !',style: TextStyle(fontSize: 14,color: Colors.blue),),
                                ),
                              ],
                            ),


                          ],),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}
