import 'dart:async';

import 'package:flutter/material.dart';

import 'movie.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: MyHomepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),
    ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MovieListScreen()
    )
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlutterLogo(size: MediaQuery.of(context).size.height,),
    );
  }
}
