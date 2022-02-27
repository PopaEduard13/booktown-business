import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/service_widget.dart';
import '../screens/place_details_screen.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = "/ServicesScreen";

  const ServicesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          args.titlu,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('places')
            .document(args.placeid)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting ||
              !streamSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final document = streamSnapshot.data;
          return ListView.builder(
              itemCount: document['servicii'].length,
              itemBuilder: (ctx, i) {
                return ServiceWidget(
                    args.placeid,
                    document['servicii'][i]['serviciu'] as String,
                    document['servicii'][i]['pret'] as int,
                    args.titlu);
              });
        },
      ),
    );
  }
}
