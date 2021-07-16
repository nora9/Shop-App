
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel{
final String image;
final String title;
final String body;

BoardingModel({
  required this.title,
  required this.image,
  required this.body,
});

}

class OnBoardingScreen extends StatelessWidget {

  var boardController = PageController();
  bool islast=false;

  void submit(BuildContext context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: defaultTextButton(
                function: (){
                  submit(context);
                },
                text: 'skip'
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if(index == boarding.length-1){
                    islast=true;
                  }else{
                    islast=false;
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,

              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect:ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ) ,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast==true){
                      submit(context);
                    }else{
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }

                  },
                  child: Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildBoardingItem(BoardingModel boarding) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${boarding.image}')
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${boarding.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${boarding.body}',
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
