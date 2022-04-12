import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:robustremedy/screen/Address_Screen/Add_new.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group_list.dart';
import 'package:robustremedy/screen/Item_group_screen/related_products.dart';
import 'package:robustremedy/screen/Item_group_screen/Wishlist.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/home/header2.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/home/summer_items.dart';
import 'package:robustremedy/screen/Item_group_screen/reviews.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/badge.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:translator/translator.dart';

class ListDetails extends StatefulWidget {
  final todo;

  ListDetails({Key key, @required this.todo}) : super(key: key);

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleTranslator translator = GoogleTranslator();
  String selectedvalue;
  String cart_total = '0';
  String enitemproductgrouptitle;
  String description_;
  String endescription;
  String addinformation;
  String enaddinformation;
  String Description_ = "Description";
  String shortdesc;
  String enshortdesc;
  String addDescription_ = "Additional Description";
  double manufacture = 14;
  double itemproductgrouptitle = 19;
  double shortdescription = 13;
  double Description = 15;
  // CarouselController buttonCarouselController = CarouselController();
  List dropdata = List();
  String cart = null;

  String itemproductgrouptitle_;

  getStringValuesSF() async {
    var url2 =
        'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("id");
    var data2 = {'userid': user_id};

    // Starting Web API Call.
    var response2 = await http.post(url2, body: json.encode(data2));
    setState(() {
      cart_total = jsonDecode(response2.body);
      if (cart_total == null) {
        cart_total = '0';
      }
    });
  }

  Future getallvalue() async {
    var data = {'itemproductgroupid': widget.todo.itemproductgroupid};
    var response = await http.post(
        'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php',
        body: json.encode(data));
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    setState(() {
      dropdata = jsondata;
    });
  }

  Future getselectedvalue() async {
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown.php';
    var data = {'id': selectedvalue};
    var response = await http.post(url, body: json.encode(data));
    // if(response.statusCode == 200) {
    //var url='https://onlinefamilypharmacy.com/mobileapplication//dropdown.php';
    // var response = await http.get(url);
    var jsondataval = json.decode(response.body);

    return jsondataval;
    // }
  }

  double finalapricedata;
  bool visible = false;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  Future addtofav() async {
    dynamic token = await getStringValues();
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/addtofav.php';
    print(url);
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      var data = {
        'user_id': token,
        'id': itemid,
        'title': widget.todo.itemname_en,
        'desc': widget.todo.itemproductgrouptitle,
        'price': widget.todo.maxretailprice
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      showInSnackBar(message);
      // SweetAlert.show(context, title:message,confirmButtonColor:LightColor.midnightBlue, );
    }
  }

  Future addtocart() async {
    dynamic token = await getStringValues();
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
//    else if (selectedvalue == null) {
//      showInSnackBar("Select Variant");
//    }
    else {
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/addtocart.php';
      if (selectedvalue == null) {
        setState(() {
          finalapricedata = finalprice;
        });
      } else {
        print('dropprice');
        print(dropprice);
        finalapricedata = dropprice;
        print(finalapricedata);
      }
      var data = {
        'user_id': token,
        'id': itemid,
        'price': widget.todo.maxretailprice,
        'finalprice': finalapricedata,
        'quantity': counter,
        'variant': selectedvalue
      };
      print(data);
      print('finalapricedata');
      print(finalapricedata);
      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      getStringValuesSF();
      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      showInSnackBar(message);
      // SweetAlert.show(context, title:message,confirmButtonColor:LightColor.midnightBlue, );
    }
  }

  double dropprice;
  int itemid;
  int counter;
  //final productprice;
  double finalprice;
  double prices;
  void increment() {
    if (selectedvalue == null) {
      setState(() {
        counter++;
        finalprice = double.parse(widget.todo.maxretailprice) * counter;
        finalapricedata = finalprice;
      });
    } else {
      setState(() {
        counter++;
        dropprice = prices * counter;
        finalapricedata = dropprice;
      });
    }
  }

  void decrement() {
    if (selectedvalue == null) {
      setState(() {
        counter--;
        finalprice = double.parse(widget.todo.maxretailprice) * counter;
        finalapricedata = finalprice;
      });
    } else {
      setState(() {
        counter--;
        dropprice = prices * counter;
        finalapricedata = dropprice;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getallvalue();
    getselectedvalue();
    getStringValuesSF();
    itemid = int.parse(widget.todo.itemid);
    finalprice = double.parse(widget.todo.maxretailprice);
    counter = 1;
    itemproductgrouptitle_ = widget.todo.itemproductgrouptitle;
    enitemproductgrouptitle = widget.todo.itemproductgrouptitle;
    enaddinformation = widget.todo.additionalinformation;
    description_ = widget.todo.description;
    endescription = widget.todo.description;
    addinformation = widget.todo.additionalinformation;
    shortdesc = widget.todo.shortdescription;
    enshortdesc = widget.todo.shortdescription;
  }

  void changeFontSize(value) async {
    var val = value;
    if (val == 2) {
      setState(() {
        manufacture = 18;
        itemproductgrouptitle = 23;
        shortdescription = 17;
        Description = 19;
      });
    } else if (val == 3) {
      setState(() {
        manufacture = 10;
        itemproductgrouptitle = 15;
        shortdescription = 9;
        Description = 11;
      });
    } else {
      setState(() {
        manufacture = 14;
        itemproductgrouptitle = 19;
        shortdescription = 13;
        Description = 15;
      });
    }
  }

  String text = 'hi';
  void translate(value) {
    var val = value;
    if (val == 1) {
      translator.translate(itemproductgrouptitle_, to: "ar").then((output) {
        setState(() {
          itemproductgrouptitle_ = output.toString();
        });
      });
      translator.translate(Description_, to: "ar").then((output) {
        setState(() {
          Description_ = output.toString();
        });
      });
      translator.translate(addDescription_, to: "ar").then((output) {
        setState(() {
          addDescription_ = output.toString();
        });
      });
      translator.translate(description_, to: "ar").then((output) {
        setState(() {
          description_ = output.toString();
        });
      });
      translator.translate(addinformation, to: "ar").then((output) {
        setState(() {
          addinformation = output.toString();
        });
      });
      translator.translate(shortdesc, to: "ar").then((output) {
        setState(() {
          shortdesc = output.toString();
        });
      });
    } else {
      setState(() {
        itemproductgrouptitle_ = enitemproductgrouptitle;
        Description_ = "Description";
        addDescription_ = "Additional Description";
        description_ = endescription;
        addinformation = enaddinformation;
        shortdesc = enshortdesc;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //getStringValuesSF();
    //List<int> sizeList = [7, 8, 9, 10];
    Color cyan = Color(0xff37d6ba);
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    int itemCount = 0;
    var _value;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back)),

        title: Text(itemproductgrouptitle_.toString()),

        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Default"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Large"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Small"),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _value = value;
                changeFontSize(value);
              });
            },
            icon: ImageIcon(
              AssetImage("assets/font.png"),
              // size: 50,
              color: LightColor.midnightBlue,
            ),
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Arabic"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("English"),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _value = value;
                translate(value);
              });
            },
            icon: ImageIcon(
              AssetImage("assets/arabic.png"),
              // size: 50,
              color: LightColor.midnightBlue,
            ),
          ),

          Badge(
              value: cart_total.toString(),
              color: LightColor.midnightBlue,
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: LightColor.midnightBlue,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                  // do something
                },
              )),
          //),
        ],
        // backgroundColor: LightColor.midnightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      width < 600
                          ? Column(children: <Widget>[
                              Stack(
                                children: [
                                  Container(
                                      // padding: EdgeInsets.only(left: 15, right: 15),
                                      height: 300.0,
                                      width: width,
                                      child: Carousel(
                                        images: [
                                          NetworkImage(
                                              'https://onlinefamilypharmacy.com/images/item/' +
                                                  widget.todo.img),
                                          NetworkImage(
                                            'https://onlinefamilypharmacy.com/images/item/' +
                                                widget.todo.img,
                                          ),
                                          NetworkImage(
                                            'https://onlinefamilypharmacy.com/images/item/' +
                                                widget.todo.img,
                                          ),
                                        ],
                                        dotSize: 6.0,
                                        dotSpacing: 15.0,
                                        dotColor: LightColor.midnightBlue,
                                        indicatorBgPadding: 5.0,
                                        // dotBgColor: LightColor.yellowColor.withOpacity(0.5),
                                        borderRadius: true,
                                      )),
                                  Positioned(
                                    top: 10,
                                    child: Container(
                                        // padding: EdgeInsets.only(left: 15, right: 15),
                                        height: 300.0,
                                        width: width,
                                        child: Container(
                                          child: Image.asset(
                                              'assets/watermark.png'),
                                        )),
                                  ),
                                ],
                              ),
                              // SizedBox(),

                              /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                              SizedBox(height: 10),
                              /*  */
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 15),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  itemproductgrouptitle_.toString(),
                                  style: TextStyle(
                                      fontSize: itemproductgrouptitle,
                                      color: LightColor.midnightBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // SizedBox(width: 5),
                              /**/
                              // ]),),

                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "Manufacture- ${widget.todo.manufactureshortname}",
                                          style: TextStyle(
                                              fontSize: manufacture,
                                              color: LightColor.midnightBlue),
                                        ),
                                      ),
                                      SizedBox(width: 130),
                                      IconButton(
                                        icon: Icon(Icons.favorite, size: 30.0),
                                        onPressed: () {
                                          addtofav();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 30.0,
                                        ),
                                        onPressed: () {
                                          final RenderBox box =
                                              context.findRenderObject();
                                          Share.share(
                                              widget.todo.itemname_en +
                                                  '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                                  '\n\n https://www.onlinefamilypharmacy.com/ecommerce/public/productdetails.php?code=' +
                                                  widget.todo.itemid,
                                              subject: "this is the subject",
                                              sharePositionOrigin:
                                                  box.localToGlobal(
                                                          Offset.zero) &
                                                      box.size);
                                        },
                                      ),
                                    ]),
                              ),
                              getprice(widget.todo.minretailprice,
                                  widget.todo.maxretailprice),

                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  shortdesc.toString(),
                                  style: TextStyle(
                                      fontSize: shortdescription,
                                      color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                              SizedBox(height: 10),

                              Container(
                                height: 15,
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Reviews_screen(
                                                        itemproductid: widget
                                                            .todo
                                                            .itemproductgroupid)));
                                      },
                                      child: Text(
                                        "View Reviews",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: LightColor.midnightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 10),
                            ])
                          : Row(children: <Widget>[
                              Container(
                                  // padding: EdgeInsets.only(left: 15, right: 15),
                                  alignment: Alignment.topLeft,
                                  height: 300.0,
                                  width: width / 2,
                                  child: Carousel(
                                    images: [
                                      NetworkImage(
                                          'https://onlinefamilypharmacy.com/images/item/' +
                                              widget.todo.img),
                                      NetworkImage(
                                        'https://onlinefamilypharmacy.com/images/item/' +
                                            widget.todo.img,
                                      ),
                                      NetworkImage(
                                        'https://onlinefamilypharmacy.com/images/item/' +
                                            widget.todo.img,
                                      ),
                                    ],
                                    dotSize: 6.0,
                                    dotSpacing: 15.0,
                                    dotColor: LightColor.midnightBlue,
                                    indicatorBgPadding: 5.0,
                                    dotBgColor:
                                        LightColor.yellowColor.withOpacity(0.5),
                                    borderRadius: true,
                                  )),
                              // SizedBox(),

                              /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                              SizedBox(height: 10),
                              /*  */

                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                itemproductgrouptitle_
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        itemproductgrouptitle,
                                                    color:
                                                        LightColor.midnightBlue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // SizedBox(width: 5),
                                            /**/
                                            // ]),),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        "\ Manufacture- ${widget.todo.manufactureshortname}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                manufacture,
                                                            color: LightColor
                                                                .midnightBlue),
                                                      ),
                                                    ),
                                                    SizedBox(width: 100),
                                                    IconButton(
                                                      icon: Icon(Icons.favorite,
                                                          size: 30.0),
                                                      onPressed: () {
                                                        addtofav();
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.share,
                                                        size: 30.0,
                                                      ),
                                                      onPressed: () {
                                                        final RenderBox box =
                                                            context
                                                                .findRenderObject();
                                                        Share.share(
                                                            widget.todo
                                                                    .itemname_en +
                                                                '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                                                '\n\n https://www.onlinefamilypharmacy.com/ecommerce/public/productdetails.php?code=' +
                                                                widget.todo
                                                                    .itemid,
                                                            subject:
                                                                "this is the subject",
                                                            sharePositionOrigin:
                                                                box.localToGlobal(
                                                                        Offset
                                                                            .zero) &
                                                                    box.size);
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                            getprice(widget.todo.maxretailprice,
                                                widget.todo.minretailprice),

                                            SizedBox(height: 10),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                shortdesc.toString(),
                                                style: TextStyle(
                                                    fontSize: shortdescription,
                                                    color: Colors.grey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 6,
                                              ),
                                            ),
                                            SizedBox(height: 10),

                                            Container(
                                              height: 15,
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Reviews_screen(
                                                                      itemproductid: widget
                                                                          .todo
                                                                          .itemproductgroupid)));
                                                    },
                                                    child: Text(
                                                      "View Reviews",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: LightColor
                                                              .midnightBlue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(height: 10),
                                          ])))
                            ]),
                      CustomDividerView(),
                      Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: DropdownButton(
                                    value: selectedvalue,
                                    hint: Text(widget.todo.itempack),
                                    items: dropdata.map(
                                      (list) {
                                        return DropdownMenuItem(
                                            child: SizedBox(
                                              width: 150,
                                              child: Text(list['itempack']),
                                            ),
                                            value: list['id']);
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedvalue = value;
                                        getselectedvalue();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 3),
                                selectedvalue != null
                                    ? Container(
                                        height: 50,
                                        width: 150,
                                        child: FutureBuilder(
                                            future: getselectedvalue(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data.length == 0) {
                                                  return Text(
                                                      "No data on this itempack");
                                                }
                                                return ListView.builder(
                                                    itemCount:
                                                        snapshot.data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var list =
                                                          snapshot.data[index];
                                                      itemid =
                                                          int.parse(list['id']);
                                                      dropprice = double.parse(
                                                          list['rs']);
                                                      prices = dropprice;

                                                      return ListTile(
                                                        title: Text(
                                                          "\QR ${list['rs'].toString()}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      );
                                                    });
                                              }
                                              return Text("");
                                            }))
                                    : Text(""),
                              ])),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                decrement();
                              },
                            ),
                            SizedBox(width: 10),
                            Text(
                              '$counter',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                increment();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomDividerView(),
                      SizedBox(height: 10),
                      selectedvalue == null
                          ? Container(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "\ Item Code- ${widget.todo.itemid}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),

                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  //finalprice=data[index].price,
                                  Text(
                                    "\ Item Name- ${widget.todo.itemname_en}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    "\ Type Of Packing- ${widget.todo.itempack}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),

                                  SizedBox(height: 5),

                                  /* SizedBox(height: 1),
                                  Text(
                                    "\ Type- ${widget.todo.type}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    "\ Class- ${widget.todo.itemclassid}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    "\ Strength- ${widget.todo.itemstrength}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    "\ Dosage- ${widget.todo.itemdosageid}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    "\ Origin- ${widget.todo.origin}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: LightColor.midnightBlue),
                                  ),*/
                                  SizedBox(height: 1),
                                ],
                              ),
                            )
                          : Container(
                              height: 70,
                              width: 150,
                              child: FutureBuilder(
                                  future: getselectedvalue(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.length == 0) {
                                        return Text("No data on this itempack");
                                      }
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            var list = snapshot.data[index];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "\ Item Code- ${list['id'].toString()}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: LightColor
                                                          .midnightBlue),
                                                ),

                                                SizedBox(
                                                  height: 1.0,
                                                ),
                                                //finalprice=data[index].price,
                                                Text(
                                                  "\ Item Name- ${list['itemname_en']}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: LightColor
                                                          .midnightBlue),
                                                ),
                                                SizedBox(height: 1),
                                                Text(
                                                  "\ Type Of Packing- ${list['itempack']}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: LightColor
                                                          .midnightBlue),
                                                ),
                                                SizedBox(height: 1),
                                              ],
                                            );
                                          });
                                    }
                                    return Text("");
                                  })),
                      Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            widget.todo.stock == null ||
                                    widget.todo.stock == '0'
                                ? 'Out Of Stock'
                                : widget.todo.stock + ' In Stock',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 1),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          Description_.toString(),
                          style: TextStyle(
                              fontSize: Description,
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          description_.toString(),
                          style: TextStyle(
                              fontSize: shortdescription, color: Colors.grey),
                          //overflow: TextOverflow.ellipsis, maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          addDescription_.toString(),
                          style: TextStyle(
                              fontSize: Description,
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          addinformation.toString(),
                          style: TextStyle(
                              fontSize: shortdescription, color: Colors.grey),
                          //overflow: TextOverflow.ellipsis, maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'Related Products',
                          style: TextStyle(
                              fontSize: Description,
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 180,
                        child: Related_products(
                            itemid: widget.todo.itemgroupid,
                            itemc: widget.todo.itemproductgroupid),
                        //Related_products(),
                      ),
                      footerview(),
                    ],
                  ),
                ),
              ),
            ]),
          )),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add_shopping_cart,
          color: LightColor.midnightBlue,
        ),
        label: Text(
          "Add to Cart",
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: LightColor.midnightBlue),
        ),
        backgroundColor: LightColor.yellowColor,
        onPressed: () {
          if (widget.todo.stock == '0' || widget.todo.stock == null) {
            showInSnackBar('Out of Stock');
          } else {
            addtocart();
          }
        },
        //child: Icon(Icons.shopping_cart, color: LightColor.midnightBlue),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(
          "\QR ${max}",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 15),
        child: Text("\QR ${max}",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      Text(" - "),
      Text("\QR ${min}",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    ]);
  }
}
