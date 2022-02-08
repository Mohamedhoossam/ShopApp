import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/category_data_model.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){


        return ListView.separated(
            itemBuilder:(context,index)=>buildCategoryItem(ShopCubit.get(context).categoriesModel.data!.data[index]),
            separatorBuilder:(context,index)=>separator(),
            itemCount:ShopCubit.get(context).categoriesModel.data!.data.length

        );

      } ,


    );
  }

  Widget buildCategoryItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: model.image,
          imageBuilder: (context,imageProvider)=> Image(
            image:imageProvider,
            width: 100.0,
            height: 100.0,
          ),
           // placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),



        ),

        const SizedBox(width: 20.0,),
        Text(model.name),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),


      ],),
  );
}
