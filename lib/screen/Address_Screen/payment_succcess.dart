import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'data.dart';


class PaymentSuccesful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: mediaQuery.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(child: Container(
                height: 300,
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 70.0,

                      ),
                      SizedBox(height: 10,),
                      Center(child: Text('Thank You! \n\nYour Order Has Been \n  Placed Successfully....!',textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 22,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold))),
                    ])
            )
              // ),
            ),


            Container(
              height: 70,

              child:    Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                    minWidth: width,
                    height: 70.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      color: LightColor.yellowColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Continue Shopping",
                          style: TextStyle(
                              color: LightColor.midnightBlue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    )),
              ),
            ),



//            hGap10,
//            Text(
//              'Your payment has been processed',
//              style: lessImportantText,
//            ),
//            hGap10,
            /* <----------- PayButton ------------> */
//            InkWell(
//              onTap: () {
//                Navigator.popUntil(
//                  context,
//                  ModalRoute.withName('/'),
//                );
//              },
//              child: Container(
//                width: mediaQuery.width * 0.4,
//                margin: EdgeInsets.symmetric(
//                    horizontal: 20, vertical: mediaQuery.height * 0.04),
//                padding: EdgeInsets.all(mediaQuery.height * 0.02),
//                decoration: BoxDecoration(
//                  color: primaryColor,
//                  borderRadius: BorderRadius.circular(15),
//                ),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    wGap10,
//                    Text(
//                      'Track Order',
//                      style: h1.copyWith(fontSize: mediaQuery.height * 0.02),
//                    ),
//                  ],
//                ),
//              ),
 //           ),
            /* <----------- End Of PayButton------------> */
          ],
        ),
      ),
    );
  }
}