import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Tours_Page_View/Tours_Pager.dart';

import 'listtest.dart';

class Test2 extends StatelessWidget {
 static  final Firestore database = Firestore.instance;
 static Query query = database.collection('tours');

 static Stream slides = query
      .snapshots()
      .map((list) => list.documents.map((doc) => doc.data));
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Stack(children: [
            StreamBuilder(
              stream: slides,
              initialData: [],
              builder: (context, AsyncSnapshot snap) {
                List slideList = snap.data.toList();
                return PageView.builder(
                  controller: new PageController(viewportFraction: 1),
                  itemCount: slideList.length  ,
                  itemBuilder: (context, int currentIndex) {
                      return buildstory(context);

                  },
                );
              },
            )
          ]),
        ));
  }




  GestureDetector buildstory (BuildContext context) {

    return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Test()));
            },
            child:
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Test(

                            )
                    ));
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
                margin: EdgeInsets.only(top: 120, bottom: 100, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [

                  ],
                ),
                child: Center(
                    child: Stack(
                      children: [
                        Positioned.fill(


                            child: Hero(
                              child: Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: new DecorationImage(
                                          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Baron_Palace.jpg/1024px-Baron_Palace.jpg'), fit: BoxFit.cover))),
                              tag: 'imageee',
                            )


                        ),
                        Positioned(
                            bottom: 10,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    ' hello',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 250, 250, .865)),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )),
              ),
            ));
    }
}
