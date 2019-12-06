import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Database/MuesumSnapShot.dart';
import 'package:flutter_gawlah/Tour_Items_Page_View/Tour_item_card.dart';
import 'package:flutter_gawlah/map_widgets/map2.dart';
import 'package:flutter_gawlah/Muesum/ticket.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MuseumState extends State<MuseumView> {
  final Firestore database = Firestore.instance;
  Stream Muesums;

  Stream Items;

  final PageController controllerr =
  PageController(viewportFraction: .9, keepPage: true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Muesums,
          builder: (context, AsyncSnapshot snapshot) {
            List MuesumList = snapshot.data.toList();

            return Container(
                child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _buildbackground(),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                elevation: 10,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20))),
                                    height: 200,
                                    width: 200,
                                    child: Image.network(MuesumList[0]['image'])),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .025),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              MuesumList[0]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .025,
                          ),
                          Container(
                              child: Container(
                            height: MediaQuery.of(context).size.height * .13,
                            child: Text(
                              MuesumList[0]['description'],
                              style:
                                  TextStyle(color: Colors.black, height: 1.4,fontWeight: FontWeight.bold


                                  )
                              ,
                            ),
                          )),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .025),
                          Text('Openning Hours : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Text(
                            'From : ' +
                                MuesumList[0]['Hours']['Monday'][0] +
                                ' TO ' +
                                MuesumList[0]['Hours']['Monday'][1] +
                                ' Today',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .025),
                          Sepertor(1),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .025),
                          Text(
                            'Tickets : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .005,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Children : ' +
                                    MuesumList[0]['Tickets']['Children'],
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.black54

                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                'Adults : ' +
                                    MuesumList[0]['Tickets']['Adults'],
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.black54

                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                'Photography : ' +
                                    MuesumList[0]['Tickets']['Photography'],
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.black54

                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          Sepertor(1),

                          SizedBox( height: MediaQuery.of(context).size.height * .02),
                          Text(
                            'From The Collection : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox( height: MediaQuery.of(context).size.height * .02),

                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,

                            child: StreamBuilder(
                                stream: Items,
                                builder: (context, AsyncSnapshot snapshot) {
                                  List slideList = snapshot.data.toList();
                                  return PageView.builder(
                                    physics: BouncingScrollPhysics(),
                                    controller: controllerr,
                                    itemCount: slideList.length ,
                                    itemBuilder: (context, int currentIndex) {
                                      return TourItemCard(slideList[currentIndex]);
                                    },
                                  );
                                }),
                          ),




                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .04,
                  top: MediaQuery.of(context).size.height * .05,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ));
          }),
    );
  }

  void initState() {
    Query query = database.collection('museums');
    Muesums = query
        .where("name", isEqualTo: widget.Museum)
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    super.initState();


    Query query1 = database.collection('polylines');
    Items = query1
        .where("place", isEqualTo: widget.Museum).where('type', isEqualTo: 'item')
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));



  }

  Widget Sepertor(double height) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            );
          }),
          direction: Axis.horizontal,
        );
      },
    );
  }

  Widget _buildbackground() {
    return Stack(
      children: <Widget>[

        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network('http://img.wataninet.com/2017/07/19867087_124775081462324_1074616540_o.jpg',fit: BoxFit.cover,)),
        Container(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.0)),
              ),
            )),

      ],
    );
  }
}

class MuseumView extends StatefulWidget {
  final String Museum;
  const MuseumView({Key key, this.Museum}) : super(key: key);

  MuseumState createState() => MuseumState();
}
