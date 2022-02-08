import 'package:flutter/material.dart';
import 'package:myshop/componentes/componentes.dart';
import 'package:myshop/modules/shop/screens/login_register_screen/login_screen.dart';
import 'package:myshop/network/local/local.dart';
import 'package:myshop/shared/constant/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Boarding{

  final String image;
  final String title;
  final String subtitle;
  Boarding(this.image,this.title, this.subtitle);

}


class OnBoardingScreen extends StatefulWidget {


  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
List <Boarding> boardingItem=[
  Boarding('assets/images/login1.png', 'title 1', 'subtitle 1'),
  Boarding('assets/images/login1.png', 'title 2', 'subtitle 2'),
  Boarding('assets/images/login1.png', 'title 3', 'subtitle 3'),

];
var x = 1;
var boardingControl=PageController();
var isEnd=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemBuilder:(context,index)=>buildOnBoardingScreen(boardingItem[index]),
                itemCount:boardingItem.length ,
                controller:boardingControl ,
                onPageChanged: (index){

                  if(index==boardingItem.length-1){
                    setState(() {
                      isEnd=true;
                    });
                  }else{
                    setState(() {
                      isEnd=false;
                    });
                  }

                },

              ),
            ),
            const SizedBox(height: 60.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingControl,  // PageController
                    count:  boardingItem.length,

                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 12,
                      expansionFactor: 5,
                      dotWidth: 12,
                      spacing: 5.0,
                      activeDotColor:defaultColor,
                    ) // your preferred effect

                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isEnd){
                        CacheHelper.saveData(key: 'onboarding', value: true).then((value) {

                          navigateToAndRemove(context, LoginScreen());

                        });

                      }
                      else{
                        boardingControl.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: isEnd==false?const Icon(Icons.arrow_forward_ios):const Icon(Icons.login),

                ),

            ],),


          ],
        ),
      )
    );
  }

  Widget buildOnBoardingScreen( Boarding model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children:  [
      Expanded(
        child: Image(
          image: AssetImage(model.image),

        ),
      ),
      const SizedBox(height: 20.0,),
      Text(model.title),
      const SizedBox(height: 30.0,),
      Text(model.subtitle),

    ],);
}
