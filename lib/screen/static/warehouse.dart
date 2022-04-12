import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/home/home_joinus_view.dart';
import 'package:robustremedy/screen/home/home_slider.dart';
import 'package:robustremedy/screen/static/aboutus_detail.dart';
import 'package:robustremedy/screen/static/aboutus_intro.dart';
import 'package:robustremedy/screen/static/aboutus_vision_mission_banner_view.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';

class Warehouse extends StatefulWidget {
  @override
  _About_UsScreen createState() => _About_UsScreen();
}

class _About_UsScreen extends State<Warehouse> {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Warehouse"),
      ),
      drawer: AppDrawer(),
      body: Refund(),
    );
  }
}

class Refund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/aboutus.jpeg"),

            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: Container(
                    width: 10.0,
                    height: 140.0,
                    color: LightColor.primaryBackground,
                  ),
                ),
                UIHelper.horizontalSpaceMedium(),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'FMC Warehouse',
                        style: GoogleFonts.montserrat(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Our customers always come first. We will take time to listen to you and respond to your needs. '
                            'We will be happy to get any feedback that can improve/motivate us to better our services '
                            'to you.',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            //CustomDividerView(),
            //visionmissionBannerView(),
            CustomDividerView(),
            joinusview(),
            CustomDividerView(),
            footerview(),
          ]),
    );
  }
}
