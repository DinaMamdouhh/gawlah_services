import 'package:cloud_firestore/cloud_firestore.dart';

class MueseumSnapshot
{
  getMueseum(String Muesumname)
  {
    return Firestore.instance.collection('museums').where('name',isEqualTo:Muesumname).snapshots();

  }
}