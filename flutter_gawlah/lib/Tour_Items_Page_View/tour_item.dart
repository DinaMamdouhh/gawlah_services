import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tour_item
{
  final String name;
  final LatLng location;
  final String from;
  final String period;
  final String description;
  final String image;
  final int id;
  final int date;


  const Tour_item({this.period, this.id, this.name, this.location,this.from,this.date,
    this.description, this.image});

}



