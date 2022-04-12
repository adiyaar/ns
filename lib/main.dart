import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/static/splash_screen.dart';
import 'package:robustremedy/themes/theme.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: Container(),
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Pharmacy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
//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
