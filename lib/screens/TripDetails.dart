import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tip_trip/constant.dart';
import 'package:tip_trip/screens/trips.dart';
import 'package:readmore/readmore.dart';

class TripDetails extends StatefulWidget {
  static const id = 'TripDetails';
  DocumentSnapshot detailTrip;
  TripDetails({this.detailTrip});

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  List _listOfImages = [];

  images() async {
    _listOfImages = [];
    for (int i = 0;
        i < widget.detailTrip.data()['image trip data'].length;
        i++) {
      _listOfImages.add(widget.detailTrip.data()['image trip data'][i]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images();
  }

  // delete() async {
  //   showDialog(
  //       context: context,
  //       builder: (_) {
  //         return AlertDialog(
  //           backgroundColor: Colors.white,
  //           content:
  //               Text("Are you sure?", style: TextStyle(color: Colors.black)),
  //           actions: [
  //             TextButton(
  //                 onPressed: () async {
  //                   await firebase_storage.FirebaseStorage.instance
  //                       .refFromURL(widget.detailTrip.data()['image trip'])
  //                       .delete();
  //                   for (int j = 0;
  //                       j < widget.detailTrip.data()['image trip data'].length;
  //                       j++) {
  //                     await firebase_storage.FirebaseStorage.instance
  //                         .refFromURL(
  //                             widget.detailTrip.data()['image trip data'][j])
  //                         .delete();
  //                   }

  //                   await tripsCollection
  //                       .doc(widget.detailTrip.data()['name'])
  //                       .delete()
  //                       .then((value) {
  //                     Navigator.pushReplacementNamed(context, Trips.id);
  //                   });
  //                 },
  //                 child: Text('Delete'))
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailTrip.data()['name']),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //          delete();
        //       },
        //       icon: Icon(
        //         Icons.delete,
        //         color: Colors.white,
        //       ))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: ListView(
          children: [
            Container(
                child: CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                aspectRatio: 4.0,
                enlargeCenterPage: true,
              ),
              items: _listOfImages.map((item) {
                return Container(
                  width: double.infinity,
                  child: Center(
                      child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * .97,
                        //TODO change height of image
                        height: 300,
                      ),
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  )),
                );
              }).toList(),
            )),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                'Details:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                child: ReadMoreText(
                  widget.detailTrip.data()['detail'],
                  trimLines: 2,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                  // moreStyle: TextStyle(color: Colors.black, fontSize: 12),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    'days:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.detailTrip.data()['days'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    'Price :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.detailTrip.data()['price'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Booking Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










///////////////////سيرءرءر
