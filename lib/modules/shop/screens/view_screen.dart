import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/home_data_model.dart';

class ViewScreen extends StatelessWidget {
   ViewScreen(
      {Key? key,
        required this.name,
         this.image,
        required this.description,
        required this.price,
        required this.oldPrice,required this.images, required this.model}
        ) : super(key: key);

   final String name;
    String? image;
   final String description;
   final dynamic price;
   final dynamic oldPrice;
   final List images;
   final Products model;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state){
        ShopCubit cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            color: Colors.white,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Image(image: NetworkImage(image!),width: 200,height: 200,),
                    const SizedBox(height: 10.0,),
                    Container(
                      height: 1.0,
                      width:double.infinity,
                      color: Colors.grey,
                    ),


                    // Listview Images
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder:(context,index)=>InkWell(
                          onTap: (){

                            cubit.changeImage(model.images[index]);
                            image=cubit.im;

                          },
                          child: Image(image:
                          NetworkImage(model.images[index]),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),

                        itemCount: model.images.length,scrollDirection:Axis.horizontal ,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 200,
                            width:1.0,
                            color: Colors.grey,
                          ),
                        ),


                      ),
                    ),



                    const SizedBox(height: 10.0,),
                    //name
                    Text(
                      name,
                      style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,

                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                      // price
                      Text(
                        '$price EGP ',
                        style:const TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontFamily: 'Jannah',


                        ),
                        maxLines: 4,
                      ),
                      // oldPrice
                      if(oldPrice!=price)
                        Text(
                        '$oldPrice EGP ',
                        style:const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'Jannah',


                        ),
                        maxLines: 4,

                      ),
                    ],),
                    const SizedBox(height: 10.0,),
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(2.0),
                      child:
                      const Text(
                        'description',
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,


                        ),

                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    //description
                    Text(
                      description,
                      style:const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          height: 1.5,
                        fontFamily: 'Jannah',


                      ),

                    ),



                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context,state){},

    );
  }
}
