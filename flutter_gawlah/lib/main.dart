import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Tours_Page_View/Tour_List.dart';

import 'package:flutter_gawlah/test2.dart';
import 'package:flutter_gawlah/tourview.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Tours_Page_View/Tour_List2.dart';
import 'listtest.dart';
import 'map_widgets/map2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Gawlah', home:PlacePolylinePage());
  }
}
