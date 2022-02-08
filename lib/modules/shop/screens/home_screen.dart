import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/layout/shop_cubit/cubit/shop_cubit.dart';
import 'package:myshop/layout/shop_cubit/states/shop_states.dart';
import 'package:myshop/model/home_data_model.dart';
import 'package:myshop/modules/shop/screens/searchs/search.dart';
import 'package:myshop/modules/shop/screens/view_screen.dart';
import 'package:myshop/shared/style/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  var carouselController = CarouselController();
  var boardingControl = PageController();
//PageController
  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context,state){},
      builder: (context,state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeDataModel != null,
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          builder: (BuildContext context) => homeBuildScreen(cubit.homeDataModel!,context),


        );

      }

    );
  }

  Widget homeBuildScreen(HomeDataModel model,context)=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Divider(
          color: Colors.black26,
          height: 1,
          thickness: 2,
        ),
        // Banners
        Stack(
          alignment:AlignmentDirectional.bottomCenter ,

          children: [
            CarouselSlider(
              items: model.data.banners.map((e) =>
                  CachedNetworkImage(
                    imageUrl: e.image,
                    imageBuilder: (context,imageProvider)=> Image(
                      image: imageProvider,
                      width: double.infinity,
                      fit:BoxFit.cover ,
                    ),
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),



                  ),

              ).toList(),
              options:CarouselOptions(
                autoPlayCurve: Curves.fastOutSlowIn,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval:const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                viewportFraction: 1,
                autoPlay: true,
                height: 200,
                onPageChanged: (index, reason) {
                  ShopCubit.get(context).changeIndex12(index);
                  },



              ),

             carouselController: carouselController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                    controller: PageController(
                        initialPage: ShopCubit.get(context).xy,

                    ),  // PageController
                    count:  model.data.banners.length,

                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 9,
                      expansionFactor: 4,
                      dotWidth: 9,
                      spacing: 3.0,
                      activeDotColor:Colors.blue,

                    ) // your preferred effect

                ),
              ],)
          ],
        ),

        const SizedBox(height: 5.0,),

        // Text
        const Center(
          child: Text(
              'Welcome back I\'m looking for new things!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0
            ),
          ),
        ),
        const SizedBox(height: 10.0,),

        // Search
        GestureDetector(
          onTap: (){
            navigateTo(context,  SearchScreen());
          },
          child: Container(
            height: 50.0,
            width: double.infinity,
            margin:const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
            child: Row(
              children: const [
                SizedBox(width: 12.0,),
                Text(
                  'search',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    fontFamily: 'Jannah'
                  ),
                ),
                SizedBox(width: 210.0,),
                Icon(IconBroken.Search,color: Colors.white,),
            ],),
          ),
        ),

        //GridView
        Container(
         color: Colors.white,
          child: GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 1/1.7,
    mainAxisSpacing: 1.0,
    crossAxisSpacing: 1.0,

    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
            children:
              List.generate(model.data.products.length,
                    (index) =>buildGridViewScreen(model.data.products[index],context),
              ),



          ),
        ),

      ],
    ),
  );

  Widget buildGridViewScreen( Products model ,context)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: InkWell(
      onTap: (){

        print(model.images);
        navigateTo(context, ViewScreen(
          image: model.image,
          name: model.name,
          price: model.price..round(),
          oldPrice: model.oldPrice.round(),
          description: model.description,
          images: [model.images],
          model: model,


        ));

      },
      child: Column(

        children:  [

          Stack(
            alignment:AlignmentDirectional.bottomStart ,


            children: [

              CachedNetworkImage(
                imageUrl: model.image,
                imageBuilder: (context,imageProvider)=> Image(
                  image: imageProvider,
                  height: 200,
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),

              )
              ,

              if(model.discount != 0)
              Container(
                color: Colors.red,
                child: const Text(
                  'Discount',
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 4.0,),
          Text(
            model.name,
            style:const TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              height: .98,
              fontFamily: 'Jannah',


            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0,),
          Row(children: [
            Text(
             '${ model.price.round()}',
              style:const TextStyle(
                color: Colors.blue,
                fontSize: 14.0,
                fontFamily: 'Jannah',

              ),
            ),
            const SizedBox(width: 7.0,),
            if(model.discount != 0)
              Text(
                '${ model.oldPrice.round()}',
                style:const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  decoration: TextDecoration.lineThrough,
                  fontFamily: 'Jannah',

                ),

              ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: ShopCubit.get(context).isFavorites[model.id]==true? Colors.red:Colors.grey,
              child: IconButton(
                icon:  const Icon(Icons.favorite_border,color: Colors.white,),
                onPressed: (){
                  ShopCubit.get(context).changeFavoritesItems(model.id);


                },
              ),
            ),

          ],),
        ]
      ),
    ),
  );
}
