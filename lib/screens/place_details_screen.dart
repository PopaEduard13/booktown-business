// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:maps_launcher/maps_launcher.dart';

import '../widgets/program_widget.dart';
import './gallery_screen.dart';
import '../utils/day_name.dart';
import '../utils/stars_system.dart';
import './menu_screen.dart';
import './services_screen.dart';
import './main_screen.dart';
import './edit_details_screen.dart';
import './reservations_screen.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const routeName = '/PlaceDetailsScreen';

  const PlaceDetailsScreen({Key key}) : super(key: key);
  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments as String;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(Icons.person, color: Colors.red),
            Icon(Icons.home),
            Icon(
              Icons.calendar_today,
              color: Colors.green,
            ),
          ],
          height: 50,
          color: Theme.of(context).primaryColor,
          backgroundColor: Colors.white12,
          animationDuration: Duration(milliseconds: 400),
          index: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainScreen()));
            }
            if (index == 2) {
              Navigator.of(context).pushNamed(ReservationsScreen.routeName);
            }
          },
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('places')
              .document(placeId)
              .snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting ||
                !streamSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final document = streamSnapshot.data;
            return StreamBuilder(
                stream: Firestore.instance.collection('reviews').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final reviews = snapshot.data.documents;
                  List<double> reviewsStars = [];

                  for (int i = 0; i < reviews.length; ++i) {
                    if (reviews[i]['placeId'] == placeId) {
                      reviewsStars.add(reviews[i]['nota']);
                    }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: document['imageUrl'],
                          child: Image.network(
                            document['imageUrl'],
                            height: 300,
                            width: 500,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                top: 20,
                                bottom: 15,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    document['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            EditDetailsScreen.routeName , arguments: placeId);
                                      },
                                      child: Text('EDIT DETAILS'))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Text(
                                document['description'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.timelapse),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  openClosedLocation(
                                              document['program']
                                                  [getDayByName()]['Open'],
                                              document['program']
                                                  [getDayByName()]['Close']) ==
                                          'OPEN'
                                      ? Text(
                                          'OPEN',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          'CLOSED',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                  // document['open']
                                  //     ? Text(
                                  //         'OPEN',
                                  //         style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.green,
                                  //         ),
                                  //       )
                                  //     : Text(
                                  //         'CLOSED',
                                  //         style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.red,
                                  //         ),
                                  //       ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Row(
                                      children: [
                                        Text(
                                          reviewsStars.isNotEmpty
                                              ? getRating(reviewsStars)
                                              : "0.0",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "(${reviewsStars.length})",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, left: 10, right: 5),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          GalleryScreen.routeName,
                                          arguments: document['gallery'],
                                        );
                                      },
                                      child: Text(
                                        'Galerie foto',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.place),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(document['location']),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(document['phone']),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                document['category'] == 'Restaurante' ||
                                        document['category'] == 'Cafenele'
                                    ? Navigator.of(context).pushNamed(
                                        MenuScreen.routeName,
                                        arguments: MenuArguments(
                                            placeId, document['menu']),
                                      )
                                    : Navigator.of(context).pushNamed(
                                        ServicesScreen.routeName,
                                        arguments: ScreenArguments(
                                            placeId,
                                            document['category'] == 'Cazari'
                                                ? 'Oferte cazare'
                                                : 'Servicii'),
                                      );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: Colors.grey,
                                    //       spreadRadius: 3,
                                    //       blurRadius: 3)
                                    // ],
                                    borderRadius: BorderRadius.circular(35),
                                    color: Colors.grey.shade200),
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      document['category'] == 'Restaurante' ||
                                              document['category'] == 'Cafenele'
                                          ? Icons.menu_book_outlined
                                          : document['category'] == 'Saloane' ||
                                                  document['category'] ==
                                                      'Sport' ||
                                                  document['category'] ==
                                                      'Cabinete' ||
                                                  document['category'] ==
                                                      'Entertaining'
                                              ? Icons.list
                                              : document['category'] == 'Cazari'
                                                  ? Icons.bed_rounded
                                                  : Icons.hearing,
                                      size: 34,
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      document['category'] == 'Restaurante' ||
                                              document['category'] == 'Cafenele'
                                          ? 'Meniu'
                                          : document['category'] == 'Cazari'
                                              ? 'Oferte cazare'
                                              : 'Servicii',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_right_outlined)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                MapsLauncher.launchCoordinates(
                                    document['latitude'],
                                    document['longitude']);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: Colors.grey,
                                    //       spreadRadius: 3,
                                    //       blurRadius: 3)
                                    // ],
                                    borderRadius: BorderRadius.circular(35),
                                    color: Colors.grey.shade200),
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Icon(
                                      Icons.location_pin,
                                      size: 34,
                                    ),
                                    SizedBox(width: 14),
                                    Text(
                                      'Locatie',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_right_outlined),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   padding: const EdgeInsets.all(15),
                            //   child: Column(children: [
                            //     Row(
                            //       children: [
                            //         Icon(Icons.info_rounded),
                            //         Text("Facilitati"),
                            //       ],
                            //     ),
                            //     // FacilitiesWidget(place),-
                            //   ]),
                            // ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: 250,
                              child: document['type'] == 'Cazari'
                                  ? null
                                  : ProgramWidget(document['program']),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String placeid;
  final String titlu;

  ScreenArguments(this.placeid, this.titlu);
}

class MenuArguments {
  final String placeId;
  final List<dynamic> menuPics;

  MenuArguments(this.placeId, this.menuPics);
}

String openClosedLocation(String openingHour, String closingHour) {
  final DateTime hour = DateTime.now();
  final DateTime openHour = DateFormat('Hm').parse(openingHour);
  final DateTime closeHour = DateFormat('Hm').parse(closingHour);

  if (hour.hour > openHour.hour && hour.hour < closeHour.hour ||
      hour.hour == closeHour.hour && hour.minute < closeHour.minute ||
      hour.hour == openHour.hour && hour.minute >= openHour.minute) {
    return 'OPEN';
  } else {
    return 'CLOSED';
  }
}
