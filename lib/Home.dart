import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Pages/ItemOne.dart';
import 'Pages/ItemTwo.dart';
import 'Pages/ItemThree.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indexPage = 1;

  final PageOptions = [
    ItemOne(),
    ItemTwo(),
    ItemThree()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ComplexApp"),
        backgroundColor: Colors.deepOrange,
      ),
      body: PageOptions[_indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepOrange,
        animationDuration: Duration(milliseconds: 600),
        index: 1,
        items: <Widget>[
          Icon(Icons.poll, size: 30,color: Colors.white,),
          Icon(Icons.home, size: 30,color: Colors.white,),
          Icon(Icons.comment, size: 30,color: Colors.white,),
        ],
        onTap: (int index) {
          setState(() {
            _indexPage = index;
          });
        },
      ),
    );
  }
  

}
