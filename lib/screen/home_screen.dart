import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robustremedy/screen/Item_group_screen/Wishlist.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/Item_group_screen/search_screen.dart';
import 'package:robustremedy/screen/tawkto.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';
import 'package:robustremedy/widgets/badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import '../widgets/appdrawer_without_login.dart';
import 'home/home_slider.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  //final String email;

// Receiving Email using Constructor.
  // HomeScreen ({Key key, @required this.email}) : super(key: key);
  @override
  _HomeStateScreen createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen> {
  String email;
  String cart_total = "0";
  String cart = "0";
  var user_id;

  getStringValuesSF() async {
    var url2 =
        'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString("id"); //var hataya
    var data2 = {'userid': user_id};

    // Starting Web API Call.
    var response2 = await http.post(url2, body: json.encode(data2));
    setState(() {
      print("cart");
      print(cart_total);
      cart_total = jsonDecode(response2.body);
      print(response2.body);
      print("hihihi");
    });
    //return useridValue;
    setState(() {
      email = prefs.getString("email");
      //cart_total = prefs.getString("cart_total");
      //print(cart_total);

      // id = prefs.getString('userid');
    });
  }

  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;

  static const routeName = "/";
  DateTime currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetConnect();
    getStringValuesSF(); // calls getconnect method to check which type if connection it
  }

// Receiving Email using Constructor.

  @override
  Widget build(BuildContext context) {
    //getStringValuesSF();

    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Family Pharmacy"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: LightColor.midnightBlue,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WishList()));
              // do something
            },
          ),

          /* Consumer<Cart_>(
    builder: (_,cart,ch) =>Badge(
      child: ch,
      value: cart.itemCount.toString(),
    ),
            child:   IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: LightColor.midnightBlue,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
                // do something
              },
            ),
          ),*/

// meet start

          Badge(
              value: cart_total.toString(),
              color: LightColor.midnightBlue,
              child:
              IconButton(
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

          /// meet end

//          Badge(
//              value: cart_total.toString(),
//              color: LightColor.midnightBlue,
//              child: IconButton(
//                icon: Icon(
//                  Icons.shopping_cart,
//                  color: LightColor.midnightBlue,
//                ),
//                onPressed: () {
//                  Navigator.push(
//                      context, MaterialPageRoute(builder: (context) => Cart()));
//                  // do something
//                },
//              )),
        ],
      ),

      drawer: email != null ? AppDrawer() : AppDrawer_without(),
      body: isInternetOn
          ? iswificonnected
              ? DoubleBackToCloseApp(
                  child: SliderPage(),
                  snackBar: const SnackBar(
                      content: Text('Tap back again to leave'),
                      backgroundColor: LightColor.midnightBlue),
                )
              : DoubleBackToCloseApp(
                  child: SliderPage(),
                  snackBar: const SnackBar(
                    content: Text('Tap back again to leave'),
                    backgroundColor: LightColor.midnightBlue,
                  ),
                )
          : nointernet(),

      floatingActionButton: Container(
          height: 50.0,
          width: 50.0,
          //child: FittedBox(
          child: FittedBox(
              child: FloatingActionButton(
                  //  icon: Icon(Icons.add_shopping_cart),
                  //  label: Text("Add to Cart"),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        "+97470481616", "I want to purchase this Product...");
                  },
                  child: Center(
                    child: Icon(FontAwesomeIcons.whatsapp,
                        size: 30.0, color: Colors.white),
                    //child: Icon: FaIcon(FontAwesomeIcons.whatsapp),
                    // label: Text(""),
                  )))),
    );
  }

  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });
    }
  }
}

nointernet() {
  return Stack(children: <Widget>[
    Image.asset(
      "assets/no-int.gif",
    ),
    Center(
        child: Text(
      "\n\n\n\n  No Internet Connection",
      style: TextStyle(
          fontSize: 24,
          color: LightColor.midnightBlue,
          fontWeight: FontWeight.bold),
    )),
  ]);
}

AlertDialog buildAlertDialog() {
  return AlertDialog(
    title: Text(
      "No Internet Connection Failed to Connect to Family Pharmacy. Please Check your Device's network connection and try again",
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );
}
