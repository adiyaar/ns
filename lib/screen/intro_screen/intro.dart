import 'dart:io';

import 'package:flutter/material.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/screen/intro_screen/data.dart';
import 'package:robustremedy/themes/light_color.dart';


class intro extends StatefulWidget {
  @override
  _introState createState() => _introState();
}

class _introState extends State<intro> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? LightColor.yellowColor : LightColor.midnightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xfffbba01), const Color(0xfffbba01)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(color: LightColor.midnightBlue, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: LightColor.yellowColor,
                child: Text(
                  "NEXT",
                  style: TextStyle(color: LightColor.midnightBlue, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: (){
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => (LoginScreen())));
          },

          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: LightColor.yellowColor,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
   return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
      if (width > 450 && width < 835) (
        Container(
          height: height,width: width,
    child: Column(
    children: <Widget>[
          Image.asset(imagePath,height: height/2,),
          SizedBox(
            height: 40,
          ),
          Text(title, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
  ])))
          else
        (
            Container(
                height: height,width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(imagePath),
                      SizedBox(
                        height: 40,
                      ),
                      Text(title, textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25
                      ),),
                      SizedBox(
                        height: 20,
                      ),
                      Text(desc, textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14))
                    ]))
        )
        ],
      ),
    ));
    if (width > 450 && width < 835) (
   Container(
     height: height,width: width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

      Image.asset(imagePath,height: height/4,),
      SizedBox(
        height: 40,
      ),
      Text(title, textAlign: TextAlign.center, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25
      ),),
      SizedBox(
        height: 20,
      ),
      Text(desc, textAlign: TextAlign.center, style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14))

        ],
      ),
    ));

  }
}

