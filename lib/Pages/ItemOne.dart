import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ItemOne extends StatefulWidget {
  @override
  _ItemOneState createState() => _ItemOneState();
}

class _ItemOneState extends State<ItemOne> {
  
    Future getPosts() async {
      var firestore = Firestore.instance;
      QuerySnapshot snapshot = await firestore.collection("itemOne").getDocuments();
      return snapshot.documents;
    }

    Future<Null> getRefresh() async {
      await Future.delayed( Duration(seconds: 3) );
      setState(() {
        getPosts();
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
            onRefresh: getRefresh,
              child: ListView.builder(

                  itemCount: snapshot.data.length,
                  itemBuilder: (context , index) {
                    var ourData =  snapshot.data[index];
                    return Container(
                      height: 200,
                      margin: EdgeInsets.all(10),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(margin:EdgeInsets.all(5),child: Image.network(ourData.data["image"],height: 200,fit: BoxFit.cover,)),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Container(child: Text(ourData.data["title"],style: TextStyle(
                                    color: Colors.black,fontSize: 20.0, fontWeight: FontWeight.bold
                                  ),),),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    child: Text(ourData.data["des"],maxLines : 5,style: TextStyle(
                                        color: Colors.black,fontSize: 15.0
                                    ),),

                                  ),
                                  SizedBox(height: 10.0,),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        customDialog(context, ourData.data['image'], ourData.data['title'], ourData.data['des']);
                                      },

                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.all(7),
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.deepOrangeAccent
                                        ),
                                        child: Text("More details",style: TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

              }),
            );
          }
         },
      ),
    );
}

customDialog(BuildContext context,String img,String title,String des) {
return showDialog(context: context,
builder: (context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),),
    child: Container(
      height: MediaQuery.of(context).size.height/1.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.pink,
            Colors.red,
            Colors.green,
            Colors.grey
          ],
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 10,),
            Image.network(img,height: 250,),
            SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.all(5),
                child: Text(des,style: TextStyle(color: Colors.white,fontSize: 17),))
          ],
        ),
      ),
    ),
  );
});
}

}
