import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/bezierContainer.dart';
import 'package:toast/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
List data = List();
String selectedvalue;
final String url1 =
    'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea';
class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final buildingController = TextEditingController();
  final zoneController = TextEditingController();
  final streetController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
    var android= AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios= IOSInitializationSettings();
    var initialise= InitializationSettings(android:android, iOS:ios );
    flutterLocalNotificationsPlugin.initialize(initialise,onSelectNotification: onSelectionNotification);
    //checkLogin();
  }
  Future onSelectionNotification(String payload) async{
    if(payload != null){
      debugPrint("Notification :" +payload);
    }
  }

  Future<String> fetchData() async {
    var response = await http.post(url1);

    if (response.statusCode == 200) {
      var res = await http
          .post(Uri.encodeFull(url1));

      var resBody = json.decode(res.body);
      print("___________JSJSJS");
      print(resBody);

      setState(() {
        data = resBody;
      });

      print('Loaded Successfully');

      return "Loaded Successfully";
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future showNotification() async{
    var android = AndroidNotificationDetails('channelId', 'Online Family Pharmacy','channelDescription');
    var ios= IOSNotificationDetails();
    var platform= NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(0, 'Thank you for your Registration', 'Shop online on Qatars Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.',platform,payload:'some details');
  }

  _getLocation() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }
  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String firstname = fnameController.text;
    String lastname = lnameController.text;
    String mobileno = mobileController.text;
    String email = emailController.text;
    String buildingno = buildingController.text;
    String zone = selectedvalue;
    String street = streetController.text;
    String password = passwordController.text;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (firstname.length == 0 ||
        lastname.length == 0 ||
        buildingno.length == 0 ||
        selectedvalue.length == 0 ||
        street.length == 0 ||
        password.length == 0) {
      showInSnackBar("Field Should not be empty");

    } else if (!regex.hasMatch(email)) {
      showInSnackBar("Enter Valid Email");

    } else {
      // SERVER API URL
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/register.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'lastname': lastname,
        'mobileno': mobileno,
        'email': email,
        'buildingno': buildingno,
        'zone': zone,
        'street': street,
        'password': password
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      showNotification();
     fnameController.clear();
       lnameController.clear();
     mobileController.clear();
       emailController.clear();
      buildingController.clear();
       zoneController.clear();
      streetController.clear();
       passwordController.clear();
      showInSnackBar(message);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // Showing Alert Dialog with Response JSON Message.
      /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );*/
    }
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context,animation,animationTime,child){
                  return FadeTransition(
                    opacity:animation,
                    child: child,
                  );
                },
                pageBuilder: (context,animation,animationTime){
                  return LoginScreen();
                }));

      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/Login/fmc_logo.png'),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "First Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            width: 120,
          ),
          Text(
            "Last Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            width: 180.0,
            child: TextField(
              controller: fnameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 180.0,
            child: TextField(
              controller: lnameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "Mobile No",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            width: 80.0,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '+974',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 280.0,
            child: TextField(
              controller: mobileController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Text(
          "Email Id",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true),
        ),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          /*SizedBox(
            width: 10,
          ),*/
          Text(
            "Building No",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            // width: 44,
          ),
          Text(
            "Zone/Area",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            //  width: 60,
          ),
          Text(
            "Street",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: TextField(
                  controller: buildingController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f4),
                ),
                child: DropdownButton(

                  value: selectedvalue,
                  hint: Text("Select area",),
                  items: data.map(
                        (list) {

                      return DropdownMenuItem(
                          child: SizedBox(
                            width: 100.0,
                            child: Text(list['zone']+"-"+ list['area']),
                          ),

                          value: list['id']);
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value;
                      print(
                          "-----------------------------------------SELECTED");
                      print(selectedvalue);

                    });
                  },
                ),
              ),

              SizedBox(
                width: 10,
              ),
              Container(
                  width: 100.0,
                  child: TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true),
                  ))
            ]),
        SizedBox(
          height: 10,
        ),
        Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    //_emailPasswordWidget(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      Container(
                          width: width/2.3,
                          child: Text(
                        "First Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                      SizedBox(
                        width: width/38,
                      ),
                      Container(
                          width: width/2.3,
                          child: Text(
                        "Last Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[

                      Container(
                        width: width/2.3,
                        child: TextField(
                          controller: fnameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        width: width/38,
                      ),
                      Container(
                        width: width/2.3,
                        child: TextField(
                          controller: lnameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      Text(
                        "Mobile No",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      Container(
                        width: width/5.5,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: '+974',
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        width:width/38,
                      ),
                      Container(
                        width: width/1.45,
                        child: TextField(
                          controller: mobileController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Text(
                      "Email Id",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),]),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      /*SizedBox(
            width: 10,
          ),*/
                      Container(
                        width: width/3.6,
                        child:Text(
                        "Building No",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                      SizedBox(
                        width: width/38,
                      ),
                      Container(
                          width: width/3.6,
                          child:Text(
                        "Zone/Area",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                      SizedBox(
                        width: width/38,
                      ),
                      Container(
                          width: width/3.6,
                          child: Text(
                        "Street",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width/3.6,
                            child: TextField(
                              controller: buildingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          ),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff3f3f4),
                            ),
                            child: DropdownButton(

                              value: selectedvalue,
                              hint: Text("Select area",),
                              items: data.map(
                                    (list) {

                                  return DropdownMenuItem(
                                      child: SizedBox(
                                        width: 95.0,
                                        child: Text(list['zone']+"-"+ list['area']),
                                      ),

                                      value: list['id']);
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedvalue = value;
                                  print(
                                      "-----------------------------------------SELECTED");
                                  print(selectedvalue);

                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                              width: width/3.6,
                              child: TextField(
                                controller: streetController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                              ))
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),]),
                    TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true)),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Button(
                        onClick: userRegistration,
                        btnText: "Registration",
                      ),
                    ),
                    // SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.midnightBlue ,));
  }
  showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

class Button extends StatelessWidget {
  var btnText = "";
  var onClick;

  Button({this.btnText, this.onClick});
  Color yellowColors = Colors.yellow[700];
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  @override
  Widget build(BuildContext context) {
    return  BouncingWidget(
        duration: Duration(milliseconds: 100),
        scaleFactor: 1.5,
        onPressed: onClick,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [yellowColors, Color(0xfffbb448)])),
          child: InkWell(
            child: Text(
              'Register Now',
              style: TextStyle(
                  fontSize: 20,
                  color: midnightBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
