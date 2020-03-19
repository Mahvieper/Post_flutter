import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
class ItemTwo extends StatefulWidget {
  @override
  _ItemTwoState createState() => _ItemTwoState();
}

class _ItemTwoState extends State<ItemTwo> {

  Future getHomePost() async {
    var firestore = Firestore.instance;
    
    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();
    return snap.documents;
  }
  
  
  Future<Null>getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getHomePost();
    });
  }

  List<MaterialColor> _colorsList = [
    Colors.orange,
    Colors.brown,
    Colors.purple,
    Colors.red,
    Colors.blueGrey
  ];

  MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getHomePost(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else
            return RefreshIndicator(
              onRefresh: getRefresh,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index) {
                    var mydata = snapshot.data[index];
                    color = _colorsList[index % _colorsList.length];
                    return Container(
                      height: 300,
                      margin: EdgeInsets.all(10),
                      child: Card(
                        elevation: 10.0,
                        child: Column(
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Text(mydata.data["title"][0]),
                                    backgroundColor: color,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(mydata.data["title"],style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        customDialog(context, mydata.data["title"], mydata.data["image"], mydata.data["des"]);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        child: Icon(Icons.more_horiz),


                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                           /* Text("Mahesh",style: TextStyle(
                              fontSize: 32
                            ),)*/
                           SizedBox(height: 5,),
                            Container(
                              margin: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(mydata.data["image"],
                                  fit: BoxFit.cover,),
                                ),
                                height: 200.0,
                              width: MediaQuery.of(context).size.width,
                            ),


                          ],
                        ),
                      ),
                    );
              }),
            );
        },
      ),
    );
  }

  customDialog(BuildContext context,String title,String img,String des) {
    return showDialog(context: context,
        builder: (context) {
          return Dialog(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(title,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Image.network(img,fit: BoxFit.cover,),
                    SizedBox(height: 10,),
                   Expanded(child: Container(height:double.infinity,
                       padding:EdgeInsets.all(5),
                       margin: EdgeInsets.only(bottom: 10),
                       child: Text(des,style: TextStyle(fontSize: 17,color: Colors.black),)))
                  ],
                ),
              ),
            ),
          );
        });

  }
}
