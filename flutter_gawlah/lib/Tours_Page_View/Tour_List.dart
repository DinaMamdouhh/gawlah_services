import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'dart:async';
//import 'package:flutter_gawlah/Map/google_map.dart';

import 'package:toast/toast.dart';

import '../listtest.dart';
import '../tourview.dart';

class TourList extends StatefulWidget {
  @override
  _TourListState createState() => _TourListState();
}

class _TourListState extends State<TourList> {
  // This will give them 80% width which will allow other slides to appear on the side
  final PageController controller = PageController(
    viewportFraction: 1
      ,
      keepPage:true
  );

  final Firestore database = Firestore.instance;
  //can be changed within the app
  Color _BackGroundColor;
  Stream slides;
  String activeTag = 'all';
  int currentPage = 0;

  @override
  Future initState() async {
    _BackGroundColor = Color.fromRGBO(200, 200, 200, 1);

    _queryDatabase();
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void _queryDatabase({String tag = 'all'}) {
    if (tag == 'all') {
      Query query = database.collection('tours');
      slides = query
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    } else {
      Query query =
      database.collection('tours').where('tags', arrayContains: tag);
      slides = query
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    }
    // Map the slides to the data payload

    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  Container _buildTagPage() {
    return Container(


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Themes',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 10,
              ),
              Text('FILTERS',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          Container(
            height: 20,
          ),
          _buildButton('Art'),
          _buildButton('War'),
          _buildButton('Qurans'),
          _buildButton('painting'),
        ],
      ),
    );
  }

  FlatButton _buildButton(tag) {
    Color color = tag == activeTag ? Colors.blue : Colors.transparent;
    return FlatButton(
      color: color,
      child: SizedBox(
        width: 80,
        child: Text(
          '#$tag',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () => _queryDatabase(tag: tag),
    );
  }

  GestureDetector _buildStoryPage(Map data, bool active ,BuildContext context) {
    // Animated properties
    final double blur = active ? 50 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 200 : 240;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TourView(
             
            ))
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 100, right: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: blur,
              offset: Offset(offset, offset),
            ),
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
                              image: NetworkImage(data['image']), fit: BoxFit.cover))),
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
                        data['name'],
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
    );
  }

  Widget _buildbackground() {
    return Container(
      color: _BackGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images_and_icons/g_transparent.png',
            height: 100,
          ),
          Container(
            height: 575,
          )
        ],
      ),
    );
  }

  List _themes_getter(AsyncSnapshot snapshot) {
    List themes = new List();

    for (int i = 0; i < snapshot.data.documents.length; i++) {
      List tags = snapshot.data.documents[i]['tags'];

      tags.forEach((element) {
        if (!(themes.contains(element))) {
          themes.add(element);
        }
      });
    }
    return themes;
  }



  ////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        body: Center(
      child: Stack(children: [
        _buildbackground(),
        StreamBuilder(
          stream: slides,
          initialData: [],
          builder: (context, AsyncSnapshot snap) {
            List slideList = snap.data.toList();
            return PageView.builder(

              controller: controller,


              itemCount: slideList.length+1 ,
              itemBuilder: (context, int currentIndex) {
                if (currentIndex == 0) {
                  return _buildTagPage();
                } else if (slideList.length >= currentIndex) {
                  bool active = currentIndex == currentPage;
                  return _buildStoryPage(slideList[currentIndex-1], active,context);
                }

              },
            );
          },
        )
      ]),
    ));
  }



}
