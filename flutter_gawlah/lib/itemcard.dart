

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String size;
  const ItemCard({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){


      },
      
          child: this.size== 'big'? Container(
        child: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.width*0.72,
                width: MediaQuery.of(context).size.width*0.7,
                child: Hero(
                  tag: 'tour',
                  //'https://upload.wikimedia.org/wikipedia/commons/6/6c/Yusef_Zuleykha.jpg',
                        child: Image.network(
                    
                    'https://www.1st-art-gallery.com/frame-preview/40876343.jpg?sku=Unframed&thumb=0&huge=1',
                    fit: BoxFit.fill,

                    
                  ),
                )),
                Positioned(
                  top: 20,
                  left: 10,
                                child: Container(
                    
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color: Colors.tealAccent,),
                    height: MediaQuery.of(context).size.height*0.03,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Center(
                      child: Text('MIDDLE AGES COLLECTION',style:TextStyle(fontSize:12,color:Colors.black,fontWeight:FontWeight.bold)),
                    ),
                  ),
                ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.05,
              right: MediaQuery.of(context).size.width*0.05,
              top: MediaQuery.of(context).size.height*0.5,
              //bottom: MediaQuery.of(context).size.height*0.02,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Birth of Venus',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white, height: 1.2
                    ),
                  ),
                  Text(
                    'Sandro Boticelli',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, //height: 1.8
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(height: MediaQuery.of(context).size.height*0.005,
                    width: MediaQuery.of(context).size.width*0.95,
                    color: Colors.white,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Row(
                      children: <Widget>[
                        Text('1484-1486',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ):
      Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.width*0.56,
                width: MediaQuery.of(context).size.width*0.5,
                child: Hero(
                  tag: 'tour',
                 
                        child: Image.network(
                    
                    'https://www.1st-art-gallery.com/frame-preview/40876343.jpg?sku=Unframed&thumb=0&huge=1',
                    fit: BoxFit.fill,

                    
                  ),
                )),
                Positioned(
                  top: 10,
                  left: 10,
                                child: Container(
                    
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color: Colors.tealAccent,),
                    height: MediaQuery.of(context).size.height*0.015,
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Center(
                      child: Text('MIDDLE AGES COLLECTION',style:TextStyle(fontSize:10,color:Colors.black,fontWeight:FontWeight.bold)),
                    ),
                  ),
                ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.05,
              right: MediaQuery.of(context).size.width*0.05,
              top: MediaQuery.of(context).size.height*0.15,
              bottom: MediaQuery.of(context).size.height*0.02,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Birth of Venus',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white, height: 1.2
                    ),
                  ),
                  Text(
                    'Sandro Boticelli',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, //height: 1.8
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(height: MediaQuery.of(context).size.height*0.005,
                    width: MediaQuery.of(context).size.width*0.4,
                    color: Colors.white,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Row(
                      children: <Widget>[
                        Text('1484-1486',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

    );
  }
}
