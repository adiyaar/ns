import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/home/viewall2.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class header {
  final String id;
  final String title;

  header(this.id, this.title);
}

class Headerf extends StatefulWidget {
  @override
  _headerstatef createState() => _headerstatef();
}

class _headerstatef extends State<Headerf> {
  final String url =
      "https://onlinefamilypharmacy.com/mobileapplication/ecommercecategory2.php";

  List<header> myAllData = [];

  @override
  void initState() {
    loadData();
    _fetchJobs(myAllData);
  }

  loadData() async {
    var response = await http.get(url, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      for (var data in jsonBody) {
        myAllData.add(new header(data['id'], data['title']));
      }

      setState(() {});
      myAllData.forEach((someData) => print("Name : ${someData.title}"));
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : showMyUI(),
    );
  }

  Future<List<Job>> _fetchJobs(_id) async {
    var data = {'epid': _id};
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode2.php';
    final response = await http.post(jobsListAPIUrl, body: jsonEncode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Widget showMyUI() {
    return new ListView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12.0),
                  child: Text(
                    myAllData[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  child: Text('See All', style:TextStyle(fontWeight: FontWeight.bold,color: LightColor.midnightBlue)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> viewAll2(epid: myAllData[index].id,)));
                  },
                )
              ],
            ),
            subtitle: FutureBuilder(
              future: _fetchJobs(myAllData[index].id),
              builder: (context, snap) {
                if (snap.hasData) {
                  List<Job> items = snap.data;
                  return Container(
                    height: 150,
                    width: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: items
                          .map((item) => InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListDetails(todo: item)));
                        },
                            child: Container(
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/noimage.jpg',
                                              image:
                                                  'https://onlinefamilypharmacy.com/images/item/' +
                                                      item.img,
                                              fit: BoxFit.fitWidth,
                                              width: 100),
                                          // child: Image.network(
                                          //   'https://onlinefamilypharmacy.com/images/item/' +
                                          //       item.img,
                                          //   fit: BoxFit.fitWidth,
                                          //   width: 100,
                                          // ),
                                        ),
                                        SizedBox(
                                            width: 120,
                                            height: 20,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                  item.itemproductgrouptitle,
                                                  textAlign: TextAlign.left,
                                                  // softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: LightColor
                                                          .midnightBlue)),
                                            )),
                                        SizedBox(
                                            width: 120,
                                            height: 20,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                              ),
                                              child: Text(
                                                  "\QR ${item.maxretailprice}",
                                                  textAlign: TextAlign.left,
                                                  // softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: LightColor
                                                          .midnightBlue)),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                          ))
                          .toList(),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
              },
            ),
          );
        });
  }
}
