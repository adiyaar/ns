import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/home/home_joinus_view.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'dart:convert';
import '../home/home_slider.dart';
import 'package:flutter_html/flutter_html.dart';
class DeliveryInfoScreen extends StatefulWidget {


  @override
  _DeliveryInfoStateScreen createState() => _DeliveryInfoStateScreen();
}
class StaticPage {

  final String content;

  StaticPage({this.content});

  factory StaticPage.fromJson(Map<String, dynamic> json) {
    return StaticPage(

      content:json['content'],
    );
  }
}
class _DeliveryInfoStateScreen extends State<DeliveryInfoScreen> {


  static const routeName = "/";


// Receiving Email using Constructor.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Delivery Information"),

      ),
      drawer: AppDrawer(),
body:DeliveryInfo(),
    );
  }
}
class DeliveryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StaticPage>>(
      future: _fetchStaticPage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<StaticPage> data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<StaticPage>> _fetchStaticPage() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=e_staticpages_deliveryinformation';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new StaticPage.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  return Container(


    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {

        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: data[index].content,
                ),
              ),

              Container(
                constraints: BoxConstraints.expand(height:190),
                child: SliderDemo(),
              ),
              SizedBox(height: 20.0,),
              CustomDividerView(),
              joinusview(),
              CustomDividerView(),
              footerview(),

            ]  );
      },

    ),


  );

}



