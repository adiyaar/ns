import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/Address_Screen/order_generated.dart';
import 'package:robustremedy/screen/Address_Screen/payment_option.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

List<int> itemcode = List();
List<int> quantity = List();
List<int> price = List();
List<Shipping> shippment = [];

class Shipping {
  final String shipping_charges;
  final String lessthan;
  final String lessthanshippingamt;

  Shipping({
    this.shipping_charges,
    this.lessthan,
    this.lessthanshippingamt,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      shipping_charges: json['shipping_charges'],
      lessthan: json['lessthan'],
      lessthanshippingamt: json['lessthanshippingamt'],
    );
  }
}

class CartItem {
  final String img;
  final String title;
  final String price;
  final String id;
  final String itemid;
  final String counter;
  final String finalprice;
  final String quantity;

  CartItem({
    this.img,
    this.itemid,
    this.title,
    this.price,
    this.id,
    this.counter,
    this.finalprice,
    this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      img: json['img'],
      itemid: json['itemid'],
      title: json['itemname_en'],
      price: json['price'],
      counter: json['counter'],
      finalprice: json['finalprice'],
      quantity: json['quantity'],
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final addid, total;
  PaymentScreen({Key key, @required this.addid, @required this.total})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedRadioTile, selectedRadio;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future getShippingCharge() async {
    String url =
        'https://onlinefamilypharmacy.com/mobileapplication/shippingcharge.php';

    Map<String, dynamic> data = {
      'zoneId': int.parse(widget.addid.zone),
      'total': int.parse(widget.total.Total)
    };
    var response = await http.post(url, body: json.encode(data));

    List jsonDecoded = json.decode(response.body);
    setState(() {
      shippment = jsonDecoded.map((e) => Shipping.fromJson(e)).toList();
    });

    return shippment;
  }

  @override
  void initState() {
    super.initState();
    getShippingCharge();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(selectedRadioTile);
    });
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  Future payment() async {
    dynamic token = await getStringValues();
    int newTotal =
        int.parse(widget.total.Total) < int.parse(shippment[0].lessthan)
            ? (int.parse(shippment[0].lessthanshippingamt) +
                int.parse(widget.total.Total) +
                int.parse(shippment[0].shipping_charges))
            : ((int.parse(shippment[0].shipping_charges) +
                int.parse(widget.total.Total)));

    var mode_service;

    if ((selectedRadioTile == 1) || (selectedRadioTile == 2)) {
      if (selectedRadioTile == 1) {
        mode_service = 'Cash On Delivery';
      } else {
        mode_service = 'Card On Delivery';
      }
      itemcode = itemcode.toSet().toList();
      // quantity = quantity.toSet().toList();
      //   price = price.toSet().toList();
      print(itemcode);
      print(quantity);
      print(price);
      var data = {
        'user_id': token,
        'addressid': widget.addid.addressid,
        'title': widget.addid.title,
        'building': widget.addid.building,
        'street': widget.addid.street,
        'area': widget.addid.area,
        'country': widget.addid.country,
        'total': newTotal,
        'mode_service': mode_service,
        'itemcode': itemcode,
        'quantity': quantity,
        'price': price
      };
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/order_payment.php';
      //https://onlinefamilypharmacy.com/mobileapplication/order_payment.php

      var response = await http.post(url, body: json.encode(data));
      print(response.statusCode);
      print("ORDEERRRRRRRRRRRRRRRRRRRRRRRRRRRRRR ");
      print(response.body.toString());

      itemcode.clear();
      quantity.clear();
      price.clear();
    }
  }

  /* @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
  }*/
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);*/
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Order Summary")),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          child: Column(children: <Widget>[
            Container(
              // height: 110*d,
              height: 250,
              child: Summary_Cart(),
            ),
            Container(
              height: height / 7,
              // child:  Total_payment_screen( ),
              child: Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "\ Payment Details",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "\ Delivery Charge",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        //TODO:: Here I have to add the code for pricing as per the area or zone code;
                                        int.parse(widget.total.Total) <
                                                int.parse(shippment[0].lessthan)
                                            ? Text(
                                                "QR ${(int.parse(shippment[0].lessthanshippingamt) + int.parse(shippment[0].shipping_charges))}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "QR ${int.parse(shippment[0].shipping_charges)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ]),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "\ Total Amount",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        int.parse(widget.total.Total) <
                                                int.parse(shippment[0].lessthan)
                                            ? Text(
                                                "QR ${int.parse(shippment[0].lessthanshippingamt) + int.parse(widget.total.Total) + int.parse(shippment[0].shipping_charges)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "QR ${int.parse(shippment[0].shipping_charges) + int.parse(widget.total.Total)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ]),
                                ])))
                  ],
                ),
              ),
            ),
            Container(
              height: height / 6,
              // child: Address_data(addid:widget.addid),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  // height: 150.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: LightColor.yellowColor,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.addid.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(children: <Widget>[
                              Text(
                                "\Bldg No - ${widget.addid.building},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Street No - ${widget.addid.street},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Area  -${widget.addid.area}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.addid.country,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: height / 4,
                child: Column(children: <Widget>[
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Cash On Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Cash / Card On Delivery"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadioTile(val);
                    },
                    activeColor: LightColor.midnightBlue,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Card On Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Radio 2 Subtitle"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadioTile(val);
                    },
                    activeColor: LightColor.midnightBlue,

                    selected: false,
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Debit / Credit Card / Paypal",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Radio 2 Subtitle"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadioTile(val);
                    },
                    activeColor: LightColor.midnightBlue,

                    selected: false,
                  ),
                ])),
            SizedBox(
              height: 60.0,
            ),
          ]),
        ),
      ])),
      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton.extended(
            //  icon: Icon(Icons.add_shopping_cart),
            //  label: Text("Add to Cart"),
            backgroundColor: LightColor.yellowColor,
            onPressed: () async {
              if (selectedRadioTile == 0) {
                showInSnackBar("Select Payment Method ");
              } else if ((selectedRadioTile == 1) || (selectedRadioTile == 2)) {
                payment();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Order_GeneratedScreen()),
                );
              } else {
                dynamic token = await getStringValues();

                var data = {
                  'user_id': token,
                  'addressid': widget.addid.addressid,
                  'title': widget.addid.title,
                  'building': widget.addid.building,
                  'street': widget.addid.street,
                  'area': widget.addid.area,
                  'country': widget.addid.country,
                  'total': widget.total.Total,
                  'mode_service': "Online Payment",
                  'itemcode': itemcode,
                  'quantity': quantity,
                  'price': price
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentOptionScreen(price, data)),
                );
              }
            },
            // icon: Icon(Icons.save),
            label: Center(
                child: Text(
              "Confirm",
              style: TextStyle(
                  fontSize: 18,
                  color: LightColor.midnightBlue,
                  fontWeight: FontWeight.bold),
            )),
          )),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}

class Summary_Cart extends StatefulWidget {
  @override
  _Summary_CartState createState() => _Summary_CartState();
}

class _Summary_CartState extends State<Summary_Cart> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CartItem>>(
        future: _fetchItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CartItem> data = snapshot.data;
            if (snapshot.data.length == 0) {
              return Image.asset("assets/empty-cart.png");
            }

            return imageSlider(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
          ));
        },
      ),
    );
  }

  Future<List<CartItem>> _fetchItem() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {
      'userid': token,
    };
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/cart_api.php';
    var response = await http.post(url, body: json.encode(data));
    print("I am here my jaan");
    print(response.body.toString());

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        int id = int.parse(data[index].itemid);
        int qt = int.parse(data[index].quantity);
        int pr = int.parse(data[index].finalprice);
        print(id);
        print(qt);
        print(pr);
        print("_______________________");
        quantity.add(qt);
        price.add(pr);
        itemcode.add(id);

        return InkWell(
            onTap: () {},
            child: Card(
                child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    child: new Image.network(
                      'https://onlinefamilypharmacy.com/images/item/' +
                          data[index].img,
                      fit: BoxFit.fitWidth,
                      width: 100,
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 120,
                    height: 50,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          data[index].title, textAlign: TextAlign.left,
                          // softWrap: true,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: LightColor.midnightBlue),
                          overflow: TextOverflow.ellipsis, maxLines: 4,
                        ),
                      ),
                    )),
//Divider(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 120,
                    height: 20,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                          "\QR ${data[index].price} x ${data[index].quantity}",
                          textAlign: TextAlign.left,
                          // softWrap: true,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: LightColor.midnightBlue)),
                    )),
                //  SizedBox( width: 120, height:20,

                //  child:
                Chip(
                  backgroundColor: LightColor.yellowColor,
                  label: Text(
                    'QR ${data[index].finalprice}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ]),
            )));
      },
    );
  }
}
