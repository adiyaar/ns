import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/themes/colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';

class Insurance_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance"),
      ),
      body: AdvertiseDemo(),
    );
  }
}

class AdvertiseDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.separatorGrey,
              ),
              borderRadius: BorderRadius.circular(5)),
          color: AppColors.whiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/alkoot.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Alkoot Insurance',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/qlm.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Q-Life Insurance',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/cigna.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cigna Health',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/allianz.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Allianz Insurace',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/globemed.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Globemed',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/aetna.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Aetna',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        constraints:
                        new BoxConstraints.expand(height: 200.0, width: 450),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(
                            left: 16.0, bottom: 8.0, top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: new NetworkImage(
                                'https://onlinefamilypharmacy.com/images/insurance/nextcare.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.highlighterBlueDark,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text('Login',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor)),
                            ),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Next Care',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                          Text('Documents Required - Original Prescription Valid Insurance Card Doctors Claim Form Qatar ID',
                              style: TextStyle(fontSize: 14.0,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              footerview(),

            ],
          ),
        ),
      ),
    );
  }
}
