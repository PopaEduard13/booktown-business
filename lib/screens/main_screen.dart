// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import './reservations_screen.dart';
import './place_details_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);
  static const routeName = "/MainScreen";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
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
          backgroundColor: Theme.of(context).primaryColor,
          animationDuration: Duration(milliseconds: 400),
          index: 1,
          onTap: (index) {
            if (index == 2) {
              Navigator.of(context).pushNamed(ReservationsScreen.routeName);
            }
            if (index == 0) {
              Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName,
                  arguments: 'Ij9Z9QhICEfLI6sqkMc4');
            }
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 40,
                      width: 170,
                      child: Image(
                        image: AssetImage('assets/logo scurtat fara carte.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 45, bottom: 40),
                    child: Text(
                      "Business",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                  child: Text(
                    "Rezervarile in asteptare :",
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream:
                      Firestore.instance.collection('reservations').snapshots(),
                  builder: (ctx, streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        !streamSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final documents = streamSnapshot.data.documents;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (ctx, i) {
                        return documents[i]['status'] == 'In asteptare'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 0.13),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(documents[i]['name']),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${documents[i]['date']} , ${documents[i]['time']}"),
                                            documents[i]['numberPeople'] != null
                                                ? Text(
                                                    "${documents[i]['numberPeople']} persoane")
                                                : Text(documents[i]['service']),
                                          ],
                                        ),
                                        trailing: FittedBox(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Firestore.instance
                                                      .collection(
                                                          'reservations')
                                                      .document(documents[i]
                                                          .documentID)
                                                      .updateData({
                                                    'status': 'Confirmata'
                                                  });
                                                },
                                                icon: Icon(Icons.check,
                                                    color: Colors.green),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Firestore.instance
                                                      .collection(
                                                          'reservations')
                                                      .document(documents[i]
                                                          .documentID)
                                                      .delete();
                                                },
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
