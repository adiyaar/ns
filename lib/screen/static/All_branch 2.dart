import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/static/All_branch_details.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/themes/light_color.dart';

import 'package:robustremedy/widgets/AppDrawer.dart';

class All_branch extends StatefulWidget {
  @override
  _All_branchState createState() => _All_branchState();
}

class _All_branchState extends State<All_branch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(" Pharmacy "),
      ),
      drawer: AppDrawer(),
      body: AllBranch(),
    );
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class allbranch {
  final String id;
  final String branchecommercename;
  final String branchname_english;
  final String shortdescription;
  final String street;
  final String zone;
  final String streetname;
  final String zonename;
  final String buildingno;
  final String area;
  final String city;
  final String country;
  final String email;
  final String img;
  final String openinghours;
  allbranch(
      {this.id,
      this.branchecommercename,
      this.branchname_english,
      this.shortdescription,
      this.street,
      this.zone,
      this.streetname,
      this.zonename,
      this.buildingno,
      this.area,
      this.city,
      this.country,
      this.email,
      this.img,
      this.openinghours});

  factory allbranch.fromJson(Map<String, dynamic> json) {
    return allbranch(
      id: json['id'],
      branchecommercename: json['branchecommercename'],
      branchname_english: json['branchname_english'],
      shortdescription: json['shortdescription'],
      street: json['street'],
      zone: json['zone'],
      streetname: json['streetname'],
      zonename: json['zonename'],
      buildingno: json['buildingno'],
      area: json['area'],
      city: json['city'],
      country: json['country'],
      email: json['email'],
      img: json['img'],
      openinghours: json['openinghours'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<allbranch>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<allbranch> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<allbranch>> _fetchallbranch() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=branch';
    //var data = {'itemid': widget.itemnull};
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 3.5),
        crossAxisCount: 1),
    itemBuilder: (context, index) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      return BranchDetails(todo: data[index]);
                    })
                //
                );
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BranchDetails(todo: data[index])));
             */
          },
          // var finalprice = data[index].price;
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.5),
                        top: BorderSide(color: Colors.grey[300], width: 1.5),
                      )),
                  height: 100.0,
                  child: Row(children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      height: 200.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://onlinefamilypharmacy.com/images/branch/' +
                                      data[index].img),
                              fit: BoxFit.fill)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text(
                                data[index].branchecommercename,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Text(
                                data[index].email,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: LightColor.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                data[index].shortdescription,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Read More',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                      color: LightColor.midnightBlue),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ]),
                    )),
                  ]))));
    },
  );
}
