// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:myshop/modules/shop/screens/login_register_screen/login_screen.dart';
//
// import '../../main.dart';
//
// class SplashScreen extends StatefulWidget {
//   final Widget widget;
//   const SplashScreen(this.widget, {Key? key}) : super(key: key);
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     startTimer();
//   }
//   startTimer()async{
//     var duration = const Duration(seconds: 3);
//     return Timer(duration, route);
//   }
//   route(){
//    Navigator.pushReplacement(context, MaterialPageRoute(
//      builder: (context)=>MyApp(widget))
//
//    );
//
//   }
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.grey,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Image(image: AssetImage('assets/images/shop1.png'),
//               width: 220,
//               ),
//               SizedBox(height: 20.0,),
//               Text(
//                 'welcome in shop app',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Colors.black
//                 ),),
//               SizedBox(height: 40.0,),
//               CircularProgressIndicator(
//                 backgroundColor: Colors.red,
//                 color:Colors.blue ,
//                 //strokeWidth: 4.0,
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
