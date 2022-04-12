import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/screen/Item_group_screen/item_subgroup.dart';


class SubList_Items extends StatefulWidget {
  final sublist; final title;

  SubList_Items({Key key, @required this.sublist,@required this.title}) : super(key: key);
  @override
  _SubList_ItemsState createState() => _SubList_ItemsState();
}

class ItemGrpData {
  final String itemid;
  final String img;
  final String itemname_en;
  final String labelname;
  final String itempack;
  final String itemstrength;
  final String itemmaingrouptitle;
  final String itemgrouptitle;
  final String itemproductgrouptitle;
  final String itemproductgroupimage;
  final String type;
  final String itemdosageid;
  final String itemclassid;
  final String manufactureshortname;
  final String seq;
  final String maxretailprice;
  final String minretailprice;
  final String rs;
  final String origin;
  final String whichcompany;
  final String allowsonapp;
  final String status;
  final String shortdescription;
  final String description;
  final String additionalinformation;
  final String itemproductgroupid;
final String itemgroupid;
  ItemGrpData(
      {this.itemid,
        this.img,
        this.itemname_en,
        this.labelname,
        this.itempack,
        this.itemstrength,
        this.itemmaingrouptitle,
        this.itemgrouptitle,
        this.itemproductgrouptitle,
        this.itemproductgroupimage,
        this.type,
        this.itemdosageid,
        this.itemclassid,
        this.manufactureshortname,
        this.seq,
        this.maxretailprice,
        this.minretailprice,
        this.rs,
        this.origin,
        this.whichcompany,
        this.allowsonapp,
        this.status,
        this.shortdescription,
        this.description,
        this.additionalinformation,
        this.itemproductgroupid,this.itemgroupid});

  factory ItemGrpData.fromJson(Map<String, dynamic> json) {
    return ItemGrpData(
        itemid: json['itemid'],
        img: json['img'],
        itemname_en: json['itemname_en'],
        labelname: json['labelname'],
        itempack: json['itempack'],
        itemstrength: json['itemstrength'],
        itemmaingrouptitle: json['itemmaingrouptitle'],
        itemgrouptitle: json['itemgrouptitle'],
        itemproductgrouptitle: json['itemproductgrouptitle'],
        itemproductgroupimage: json['itemproductgroupimage'],
        type: json['type'],
        itemdosageid: json['itemdosageid'],
        itemclassid: json['itemclassid'],
        manufactureshortname: json['manufactureshortname'],
        seq: json['seq'],
        maxretailprice: json['maxretailprice'],
        minretailprice: json['minretailprice'],
        rs: json['rs'],
        origin: json['origin'],
        whichcompany: json['whichcompany'],
        allowsonapp: json['allowsonapp'],
        status: json['status'],
        shortdescription: json['shortdescription'],
        description: json['description'],
        additionalinformation: json['additionalinformation'],
        itemproductgroupid: json['itemproductgroupid'],
        itemgroupid:json['itemgroupid']);
  }
}

class _SubList_ItemsState extends State<SubList_Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),),
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
      
    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url = 'https://onlinefamilypharmacy.com/mobileapplication/categories/list_subgroup.php';
    var data = {'itemid': widget.sublist};
    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      print(data[index]);
      return InkWell(

          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetails(todo: data[index])));
          },
          // var finalprice = data[index].price;
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.5),
                    top: BorderSide(color: Colors.grey[300], width: 1.5),
                  )),
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Container(


                    alignment: Alignment.topLeft,
                    height: 100.0,
                    width: 100.0,

                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        //image: DecorationImage(
//                            image:AssetImage('assets/noimage.jpeg'),
//                            fit: BoxFit.fill)
                        image: DecorationImage(
                            image:
                            NetworkImage('https://onlinefamilypharmacy.com/images/item/'+data[index].img),
                            fit: BoxFit.fill)
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Expanded(
                                child: Text(
                                  data[index].itemproductgrouptitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16.0),
                                  overflow: TextOverflow.ellipsis,

                                ),
                              ),
                            ]),
                            SizedBox(height: 5),
                            Row(children: <Widget>[
                              Expanded(
                                child: Text(
                                  data[index].itemmaingrouptitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 13.0,color:LightColor.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                            SizedBox(height: 5),
                            getprice(data[index].minretailprice,
                                data[index].maxretailprice),

                            /* Row(
      children: <Widget>[
                            Expanded(
                              child: Text(
                                data[index].minretailprice,
                                style: TextStyle(fontWeight: FontWeight
                                    .w600, fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                            ),]),*/
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ));
    },
  );
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Expanded(
        child: Text(
          "\QR ${max}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.midnightBlue),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Text(
        "\QR ${max}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.midnightBlue),
        overflow: TextOverflow.ellipsis,
      ),
      Text(" - "),
      Text(
        "\QR ${min}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.midnightBlue),
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}
