import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Tours_Page_View/Tours_Pager.dart';


class Test extends StatelessWidget {
  final Map data;

  const Test({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
         Scaffold(

          body :
              Hero(
              child: Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Baron_Palace.jpg/1024px-Baron_Palace.jpg'), fit: BoxFit.fill))),
              tag: 'imageee',
            )


        );
  }
}
