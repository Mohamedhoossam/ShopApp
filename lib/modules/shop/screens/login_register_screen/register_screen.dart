import 'package:flutter/material.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var EmailControler=TextEditingController();
  var PasswordControler=TextEditingController();
  var phoneControl=TextEditingController();
  var eye=Icons.visibility_off;
  var booleye=true;
  var UserName=TextEditingController();
  var AginstPasswordControler=TextEditingController();
  var formkey=GlobalKey<FormState>();

//register


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:   [
              const Text('Let\'s Get Started! ',style: TextStyle(fontSize: 30.0,fontStyle: FontStyle.normal,color: Colors.black,fontWeight: FontWeight.bold)),
              const Text('Create an account to Q Allure to get all features',style: TextStyle(fontSize: 11.0,fontStyle: FontStyle.normal,color: Colors.grey,fontWeight: FontWeight.normal)),
              const  SizedBox(height: 25.0,),



                DefultTextFormFiled(
                  radius: 30.0,
                  hintText: 'Jhone williasm',
                  fontweight: FontWeight.normal,
                  prefix: Icons.person_outline,
                  type:TextInputType.name,
                  control: UserName,
                  validate: (String? value){

                    if(value!.isEmpty){
                      return 'email not to be Empty';
                    }
                    return null;

                  },



                ),
                const  SizedBox(height: 25.0,),
                DefultTextFormFiled(
                  radius: 30.0,
                  hintText: 'Jhonewilliasm@gmail.com',
                  fontweight: FontWeight.normal,
                  prefix: Icons.email_outlined,
                  type:TextInputType.emailAddress,
                  control: EmailControler,
                  validate: (String? value){

                    if(value!.isEmpty){
                      return 'email not to be Empty';
                    }
                    return null;

                  },



                ),
                const  SizedBox(height: 25.0,),
                DefultTextFormFiled(
                  radius: 30.0,
                  hintText: 'phone',
                  fontweight: FontWeight.normal,
                  prefix: Icons.phone_android,
                  type:TextInputType.phone,
                  control: phoneControl,
                  validate: (String? value){

                    if(value!.isEmpty){
                      return 'phone not to be Empty';
                    }
                    return null;

                  },



                ),
                const  SizedBox(height: 25.0,),
                DefultTextFormFiled(
                    radius: 30.0,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'password not to be Empty';
                      }
                      return null;},
                    type: TextInputType.visiblePassword,
                    hintText: 'password',
                    prefix: Icons.lock_outline_sharp,
                    suffix: eye,
                    scure: booleye,
                    control: PasswordControler,
                    onpress: (){
                      // setState(() {
                      //   booleye=!booleye;
                      //   booleye==true?eye=Icons.visibility_off:eye=Icons.visibility;
                      //
                      //
                      // });
                    },
                    onsubmit: (value){
                      // MessengerCubit. get(context).postRegister(
                      //     email: EmailControler.text,
                      //     password: PasswordControler.text,
                      //     name: UserName.text,
                      //     phone: phoneControl.text
                      // );
                    }

                ),
                const SizedBox(height: 40.0,),
                Container(
                  child: MaterialButton(onPressed: (){},
                      child: const Text('Sign up',style: TextStyle(fontSize: 14,color: Colors.white),),
                   ),
                  width: 200,
                //  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,

                  ),

                ),
                const SizedBox(height: 40.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have an Account? '),
                    MaterialButton(
                      onPressed: (){
                        navigateToAndRemove(context, LoginScreen());
                      },
                      child: const Text('sign in',style: TextStyle(color: Colors.blue),),

                    )
                  ],
                )


            ],


            ),
          ),
        ),
      ),
    );
  }
}
