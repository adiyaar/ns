import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/static/double_back.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

var totalid;

class CartItem {
  final String img;
  final String title;

  final String price;
  final String id;
  final String finalprice;
  final String quantity;

  // final String email;
  CartItem({
    this.img,
    this.title,
    this.price,
    this.id,
    this.finalprice,
    this.quantity,
  });
//List data;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      img: json['img'],
      title: json['itemname_en'],
      price: json['price'],
      finalprice: json['finalprice'],
      quantity: json['quantity'],
    );
  }
}

class TotalItem {
  final String Total;

  // final String email;
  TotalItem({
    this.Total,
  });
//List data;
  factory TotalItem.fromJson(Map<String, dynamic> json) {
    return TotalItem(
      Total: json['Total'],
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<int> _counter_ = List();
  List<int> finalprice = List();
  int sump;
  int sum;
  int price;
  var total;

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  int counter = 0;
  int subTotal = 0;
  //final productprice;

  void increment(price, counter) {
    setState(() {
      counter++;
      // finalprice = double.parse(price) * counter;
    });
  }

  void decrement(price, counter) {
    setState(() {
      counter--;

      //finalprice = double.parse(price) * counter;
    });
  }

  Future addquantity(finalprice, quantity, id) async {
    print(finalprice);
    print(id);
    print(quantity);
    var data = {'finalprice': finalprice, 'quantity': quantity, 'id': id};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/update_cart.php';
    var response = await http.post(url, body: json.encode(data));
  }

  Future removecart(id) async {
    print(id);
    dynamic token = await getStringValues();

    var url = 'https://onlinefamilypharmacy.com/mobileapplication/remove/removecart.php';
    var data = {'id': id};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      _fetchCartItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Cart List")),
        body: Column(children: <Widget>[
          Expanded(
            child: FutureBuilder<List<CartItem>>(
              future: _fetchCartItem(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CartItem> data = snapshot.data;
                  if (snapshot.data.length == 0) {
                    return Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                        child: Image.asset("assets/cart.png"));
                  }

                  return imageSlider(context, data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
              },
            ),
          ),
          Container(
            height: 80,
            child: Total_screen(),
          ),
        ]),

        /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),

          )
        ],

      ),*/
        /*  bottomNavigationBar: new Stack(
          overflow: Overflow.visible,
          alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              height: 40.0,
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: new FloatingActionButton(

                onPressed: () => print('hello world'),
                child: new Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),*/

        floatingActionButton: Container(
            height: 50.0,
            width: 150.0,
            //child: FittedBox(
            child: FloatingActionButton.extended(
              //  icon: Icon(Icons.add_shopping_cart),
              //  label: Text("Add to Cart"),
              backgroundColor: LightColor.yellowColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Address_screen(total: totalid)));
              },
              // icon: Icon(Icons.save),
              label: Center(
                  child: Text(
                "Proceed",
                style: TextStyle(
                    fontSize: 18,
                    color: LightColor.midnightBlue,
                    fontWeight: FontWeight.bold),
              )),
            )));
  }

  Future<List<CartItem>> _fetchCartItem() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/cart_api.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    int total = 0;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        //  for (int i = 0; i < data.length; i++) {
        //    _counter_.add(1);
        //   }

        int pr1 = int.parse(data[index].finalprice);
        total += pr1;
        print(pr1);
        totalprice(total);
        // sum = total;

        print(sum);

        print(total);

        int count = int.parse(data[index].quantity);
        _counter_.add(count);
        int pr = int.parse(data[index].finalprice);
        finalprice.add(pr);

        // total += pr;
        // print(total);
        //total=(total+pr);

        return Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white12,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[100], width: 1.0),
                  top: BorderSide(color: Colors.grey[100], width: 1.0),
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
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://onlinefamilypharmacy.com/images/item/' +
                                  data[index].img),
                          fit: BoxFit.fill)),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              data[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: InkResponse(
                                onTap: () {
                                  removecart(data[index].id);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      //finalprice=data[index].price,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "\QR ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              finalprice[index].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
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
                                setState(() {
                                  if (_counter_[index] <= 1) {
                                    _counter_[index] = 1;
                                    finalprice[index] =
                                        int.parse(data[index].price) *
                                            _counter_[index];
                                  } else {
                                    _counter_[index]--;
                                    finalprice[index] =
                                        int.parse(data[index].price) *
                                            _counter_[index];
                                  }
                                  addquantity(finalprice[index],
                                      _counter_[index], data[index].id);
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text(
                              _counter_[index].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
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
                                setState(() {
                                  _counter_[index]++;
                                  finalprice[index] =
                                      int.parse(data[index].price) *
                                          _counter_[index];
                                });
                                addquantity(finalprice[index], _counter_[index],
                                    data[index].id);
                              },
                            ),
                          ],
                        ),
                      ),
                      /*  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                             new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),),
                            SizedBox(width: 5.0,), new Text(_itemCount.toString()),SizedBox(width: 5.0,),
                            new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
]),*/
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class Total_screen extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total_screen> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
      // appBar: AppBar(title: Text("Cart List")),
      body: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder<List<TotalItem>>(
            future: _fetchTotal(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TotalItem> data = snapshot.data;
                if (snapshot.data.length == 0) {
                  return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                      child: Image.asset("assets/cart.png"));
                }

                return totalSlider(context, data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
              ));
            },
          ),
        ),
      ]),
    );
  }

  Future<List<TotalItem>> _fetchTotal() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/total.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new TotalItem.fromJson(item)).toList();
  }

  totalSlider(context, data) {
    int total = 0;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        totalid = data[index];
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                height: 10.0,
                width: 10.0,
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "\ Total Amount ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            if (data[index].Total == null)
                              (Text(
                                "\ QR 0",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                            else
                              (Text(
                                "\ QR ${data[index].Total}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          ]))),
            ],
          ),
        );
      },
    );
  }
}

totalprice(int sum) {
  return sum;
}
