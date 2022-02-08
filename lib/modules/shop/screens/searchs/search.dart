import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/search_data_model.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
  var searchControl=TextEditingController();
  var isSearch = false;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              title: const Text('Search'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DefultTextFormFiled(
                        prefix: Icons.search,
                        control: searchControl,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onsubmit: (String text){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).search(text);
                          }
                          },
                        type: TextInputType.text,
                      // change: (String text){
                      //   ShopCubit.get(context).search(text);
                      // }
                    ),
                    const SizedBox(height: 5,),
                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                      Expanded(

                        child: ListView.separated(

                          itemBuilder: (BuildContext context, int index)=>
                              buildSearchItem(ShopCubit.get(context).searchModel.data!.data![index],context),
                          itemCount: ShopCubit.get(context).searchModel.data!.data!.length,
                          separatorBuilder: (BuildContext context, int index)=>separator(),
                        ),
                      ),

                  ],
                ),
              ),
            )
        );
      },
    );
  }

   Widget buildSearchItem( Data model,context)=>Padding(
     padding: const EdgeInsets.all(12.0),
     child: SizedBox(
       width: double.infinity,
       height: 122.0,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children:  [
           CachedNetworkImage(
             imageUrl: model.image!,
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
                   model.name!
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
                       '${model.price!}'
                       ,
                       style: const TextStyle(
                           color: Colors.blue,
                           fontSize: 12.0
                       ),

                     ),
                     const  SizedBox(width: 10.0,),
                     //old price
                     //if(model.discount! != 0)
                       Text(
                         '${model.price!}'
                         ,
                         style: const TextStyle(
                             color: Colors.grey,
                             fontSize: 10.0,
                             decoration: TextDecoration.lineThrough
                         ),


                       ),
                     const Spacer(),
                     CircleAvatar(
                       backgroundColor: ShopCubit.get(context).isFavorites[model.id]==true? Colors.red:Colors.grey,
                       child: IconButton(
                         icon:const Icon(Icons.favorite_border,color: Colors.white,),
                         onPressed: () {

                         //  ShopCubit.get(context).changeFavoritesItems(model.id);

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
