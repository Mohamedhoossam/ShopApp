import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateToAndRemove(context,widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context)=>widget,

),
        (route){return false;}
);

void navigateTo(context,widget)=>Navigator.push(
  context, MaterialPageRoute(
  builder: (context)=>widget,
),
);

Widget DefultTextFormFiled({
  double radius =10.0,
  IconData?  prefix,
  IconData?  suffix,
  String? labelText,hintText,
  FormFieldValidator<String>? validate,
  TextInputType? type,
  TextEditingController? control,
  VoidCallback? onpress,
  Color labelColor=Colors.grey,
  double labelFontSize=15,
  String? labelFontFamily,
  FontWeight? fontweight,
  bool scure = false,
  bool lockKeyboard=false,
  GestureTapCallback? ontap,
  ValueChanged<String>? change,
  ValueChanged<String>? onsubmit,
  Color? prefixColors,

})=>  TextFormField(
  decoration:InputDecoration(
    border: const OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.amberAccent,width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0),),

    ),


    //علشان لما يحصل خطء اغير اللون بشكل معين
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),


      // علشان لما ادخل بيلنات اغير لون الخط
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0,style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),


    ),
    // enabledBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.grey, width: 1.0,style: BorderStyle.solid),
    //     borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //
    //   ),


    prefixIcon: Icon(prefix,color: prefixColors,),
    suffixIcon: suffix!=null?IconButton(onPressed: onpress, icon: Icon(suffix)):null,
    labelText: labelText,
    labelStyle: TextStyle(color:labelColor,fontSize:labelFontSize,fontFamily:labelFontFamily  ),
    hintText :hintText,
    hintStyle: TextStyle(color:labelColor,fontSize:labelFontSize,fontFamily:labelFontFamily,fontWeight: fontweight  ),

  ) ,
  keyboardType: type,
  controller:control ,
  validator: validate,
  obscureText: scure,
  style: const TextStyle(color: Colors.black),
  readOnly: lockKeyboard,
  onTap:ontap ,
  onChanged: change,
  onFieldSubmitted:onsubmit ,



);

Widget  separator()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    color: Colors.grey,
    width: double.infinity,
    height: 1.0,
  ),
);
void toast(
    {
      required String msg,
      required Color color,

    })=>Fluttertoast.showToast(
    msg:msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);
