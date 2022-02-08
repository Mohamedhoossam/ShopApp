import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/favorites_data_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopChangeFavoritesSuccessStates){
          toast(msg:state.changeFavoritesModel.message, color: Colors.green);
        }
      },
      builder: (context,state){
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(


          body: ConditionalBuilder(
            condition:true,
            builder: (context)=>ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index)=>
                  buildFavoritesItem(ShopCubit.get(context).getFavoritesModel.dataFav!.dataList![index],context),
              itemCount: ShopCubit.get(context).getFavoritesModel.dataFav!.dataList!.length,
              separatorBuilder: (BuildContext context, int index)=>separator(),
            ),
            fallback:(context)=> const Center(child: CircularProgressIndicator()),

          ),

        );
      },

    );
  }
  Widget buildFavoritesItem(DataList model,context)=>Padding(
    padding: const EdgeInsets.all(12.0),
    child: SizedBox(
      width: double.infinity,
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          CachedNetworkImage(
            imageUrl: model.product!.image!,
            imageBuilder: (context,imageProvider)=> Image(image:imageProvider,width: 100,height: 100,),
            //placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                // name
                 Text(
                  model.product!.name!
                  ,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0
                  ),
                  maxLines: 3,
                ),
                const Spacer(),
                // prices
                Row(
                  children:  [
                    //price
                     Text(
                      '${model.product!.price!}'
                      ,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0
                      ),

                    ),
                    const  SizedBox(width: 10.0,),
                    //old price
                    if(model.product!.discount! != 0)
                     Text(
                      '${model.product!.price!}'
                      ,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough
                      ),


                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: ShopCubit.get(context).isFavorites[model.product!.id]==true? Colors.red:Colors.grey,
                      child: IconButton(
                        icon:   const Icon(Icons.favorite_border,color: Colors.white,),
                        onPressed: () {

                          ShopCubit.get(context).changeFavoritesItems(model.product!.id);

                        },

                      ),

                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    ),
  );
}
