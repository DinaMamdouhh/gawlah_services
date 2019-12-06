import 'dart:io' show Platform;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gawlah/map_widgets/page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePolylinePage extends StatelessWidget {
  const PlacePolylinePage({Key key, @required this.data, this.height, this.width1}) : super(key: key);

  final Map data;
  final double height;
  final double width1;

  @override
  Widget build(BuildContext context) {
    return PlacePolylineBody(
      data: data,
    );
  }
}

class PlacePolylineBody extends StatefulWidget {
  const PlacePolylineBody({Key key, @required this.data}) : super(key: key);

  final Map data;

  @override
  State<StatefulWidget> createState() => PlacePolylineBodyState();
}

class PlacePolylineBodyState extends State<PlacePolylineBody> with TickerProviderStateMixin {
  PlacePolylineBodyState();

  GoogleMapController controller;
  final Firestore database = Firestore.instance;
  Color department = Colors.transparent;
  Color food = Colors.transparent;
  Color halls = Colors.transparent;
  Stream Polylines;
  Set <Polygon> Polyys;

  void initState() {
    Query query = database.collection('polylines');
    Polylines = query
        .where("place", isEqualTo: 'guc' ).snapshots()
        .map((list) => list.documents.map((doc) => doc.data));

   Polyys = new Set();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  void dispose() {
    super.dispose();
  }

  LatLng _createcentre(Map museum) {
    return new LatLng(29.984863355992907,31.439433884031814);
  }

  Set <Polygon> IndoorMap(List polys, Set <Polygon> Polyys )
  {
    Polyys.clear();

    polys.forEach((PolyObj)
    {
      switch (PolyObj['type']) {
        case 'depart':
          Polyys.add(Department(PolyObj['map'], PolyObj['name']));
          break;

        default:
          break;
      }
    });

      polys.forEach((PolyObj)
      {
        switch (PolyObj['type']) {
          case 'hall':
            Polyys.add(Hall(PolyObj['map'], PolyObj['name']));
            break;

          default:
            break;
        }});

    polys.forEach((PolyObj)
    {
      switch (PolyObj['type']) {
        case 'food':
          Polyys.add(Food(PolyObj['map'], PolyObj['name']));
          break;

        default:
          break;
      }});


       polys.forEach((PolyObj)
    {
      switch (PolyObj['type']) {
        case 'lib':
          Polyys.add(Library(PolyObj['map'], PolyObj['name']));
          break;

        default:
          break;
      }});


return Polyys;


  }

  Polygon Library (List<dynamic> polylinePoints,String idd)
  {

    List<LatLng> latlngs = new List();
    polylinePoints.forEach((point)
    {
      latlngs.add(new LatLng((point as GeoPoint).latitude, (point as GeoPoint).longitude));
    }
    );

    return
      new Polygon(
    consumeTapEvents: false,
        polygonId: PolygonId(idd),fillColor: halls,
    strokeColor: Colors.black,
    strokeWidth: 5,
    visible: true,
    points: latlngs,
    );

  }

    Polygon Department (List<dynamic> polylinePoints,String idd)
  {

    List<LatLng> latlngs = new List();
    polylinePoints.forEach((point)
    {
      latlngs.add(new LatLng((point as GeoPoint).latitude, (point as GeoPoint).longitude));
    }
    );

    return
      new Polygon(
    consumeTapEvents: false,
        polygonId: PolygonId(idd),fillColor: halls,
    strokeColor: Colors.black,
    strokeWidth: 5,
    visible: true,
    points: latlngs,
    );

  }

  Polygon Hall (List<dynamic> polylinePoints,String idd)
  {
    List<LatLng> latlngs = new List();
    polylinePoints.forEach((point) {
      latlngs.add(new LatLng(
          (point as GeoPoint).latitude, (point as GeoPoint).longitude));
    }
    );

    return
      new Polygon(
        consumeTapEvents: false,
        polygonId: PolygonId(idd),fillColor: halls,
        strokeColor: Colors.black,
        strokeWidth: 5,
        visible: true,
        points: latlngs,
      );
  }

  Polygon Food (List<dynamic> polylinePoints,String idd)
  {
      List<LatLng> latlngs = new List();
      polylinePoints.forEach((point) {
        latlngs.add(new LatLng(
            (point as GeoPoint).latitude, (point as GeoPoint).longitude));
      }
      );

      return
        new Polygon(
          consumeTapEvents: false,
          polygonId: PolygonId(idd),fillColor:food,
          strokeColor: Colors.black,
          strokeWidth: 5,
          visible: true,
          points: latlngs,
        );



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: 
      StreamBuilder<Object>(
          stream: Polylines,
          builder: (context, AsyncSnapshot snapshot) {
            List slideList = snapshot.data.toList();
            return
                Stack(
                  children: <Widget>[
                    


                    Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: GoogleMap(
                            trafficEnabled: true,
                            
                            mapType: MapType.normal,
                            initialCameraPosition: new CameraPosition(
                            target: _createcentre(widget.data), zoom: 15.5),
                            polygons:  IndoorMap(slideList,Polyys),
                            

                            onMapCreated: _onMapCreated,
                          ),
                        ),

                    ),
                    Positioned(
                      height:50 ,
                      width:50 ,
                      right: 20,
                      top: 620,
                      child: FloatingActionButton(
                        onPressed:() 
                        {
                            setState(() {
                                halls = Colors.blue;
                                department = Colors.transparent;
                                food = Colors.transparent;
                            });
                        },
                        
                        
                      ),
                      
                    ),
                    Positioned(
                      height:50 ,
                      width:50 ,
                      right: 20,
                      top: 520,
                      child: FloatingActionButton(
                        onPressed:() 
                        {
                            setState(() {
                                halls = Colors.transparent;
                                department = Colors.green;
                                food = Colors.transparent;
                            });
                        },
                        
                        
                      ),
                      
                    ),
                     Positioned(
                      height:50 ,
                      width:50 ,
                      right: 20,
                      top: 420,
                      child: FloatingActionButton(
                        onPressed:() 
                        {
                            setState(() {
                                halls = Colors.transparent;
                                department = Colors.transparent;
                                food = Colors.red;
                            });
                        },
                        
                        
                      ),
                      
                    ),


              
                    //blur

                  
                    //recent search

                    //search menu background
                  
               
                  





                  ],
                );


          }),
    );
  }
}

