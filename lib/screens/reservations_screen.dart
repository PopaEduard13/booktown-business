// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './place_details_screen.dart';
import './main_screen.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key key}) : super(key: key);
  static const routeName = "/ReservationsScreen";

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  DateTime _date;

  String getMonthByName(int m) {
    final List months = [
      'Ianuarie',
      'Februarie',
      'Martie',
      'Aprilie',
      'Mai',
      'Iunie',
      'Iulie',
      'August',
      'Septembrie',
      'Octombrie',
      'Noiembrie',
      'Decembrie'
    ];
    String month = months[m - 1];
    return month;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;

    setState(() {
      _date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        index: 2,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainScreen()));
          }
          if (index == 0) {
            Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName,
                arguments: 'Ij9Z9QhICEfLI6sqkMc4');
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            "Rezervarile confirmate",
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
        ),
        leading: Container(),
        actions: [
          Container(
            width: 60,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('reservations').snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting ||
                !streamSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data.documents;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: ElevatedButton(
                        onPressed: () => pickDate(context),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    _date != null
                        ? Text(
                            '${_date.day.toString()} ${getMonthByName(_date.month)} ${_date.year.toString()}')
                        : Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Astazi , ${DateTime.now().day.toString()} ${getMonthByName(DateTime.now().month.toInt())} ${DateTime.now().year.toString()}',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: documents.length,
                  itemBuilder: (ctx, i) {
                    return documents[i]['status'] == 'Confirmata'
                        ? Column(
                            children: [
                              Padding(
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
                                  child: ListTile(
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
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          )
                        : Container();
                  },
                ),
              ],
            );
          }),
    );
  }
}
