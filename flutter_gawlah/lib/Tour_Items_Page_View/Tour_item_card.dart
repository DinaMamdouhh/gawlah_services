import 'package:flutter/material.dart';
import 'package:flutter_gawlah/map_widgets/map2.dart';
import 'package:path/path.dart';

import '../tourview.dart';

class TourItemCard extends StatelessWidget {
  final Map Tour_item;

  TourItemCard(this.Tour_item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _crearContenedor(context),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TourView(
                      
                    )));
      },
    );
  }

  Widget _crearContenedor(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 350,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    offset: Offset(0.0, 10.0),
                    spreadRadius: 0,
                    blurRadius: 10)
              ]),
          child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _Hero(),
                  _crearHeader(),
                  Column(
                    children: <Widget>[
                      Container(margin: EdgeInsets.only(top: 10)),
                      Expanded(child: Container()),
                      createtexts(context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }

  Widget _crearHeader() {
    return Column(
      children: <Widget>[
        SizedBox(height: 18,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10 , right: 10),
              child: Column(
                children: <Widget>[
                  Chip(
                    label: Text(Tour_item['period'] + ' Period'),
                    backgroundColor: Color.fromRGBO(230, 230, 230, .5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _Hero() {
    return Hero(
      child: Image(
        image: NetworkImage(Tour_item['image']),
        fit: BoxFit.cover,
      ),
      tag: Tour_item['name'],
    );
  }

  Widget createtexts(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
      // width: MediaQuery.of(context).size.width * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 25,
              ),
              Text(
                Tour_item['name'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(230, 230, 230, 1)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          new SizedBox(
            height: 4.0,
            child: new Center(
              child: new Container(
                margin: new EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: 5.0,
              //  color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 25,
              ),
              new Text(
                Tour_item['date'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10, color: Color.fromRGBO(230, 230, 230, 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
