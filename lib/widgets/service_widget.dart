import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


class ServiceWidget extends StatelessWidget {
  final String placeId;
  final String service;
  final int price;
  final String title;

  const ServiceWidget(this.placeId, this.service, this.price, this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 25,
        padding: const EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(width: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  service,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Row(
                  children: [
                    const Icon(FontAwesome.tag),
                    const SizedBox(
                      width: 5,
                    ),
                    title == 'Oferte cazare'
                        ? Text("$price RON / noapte")
                        : Text("$price RON"),
                  ],
                ),
              ],
            ),
            const Center(
              child: Icon(
                Icons.arrow_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationArguments {
  String placeId;
  String serviceTitle;

  ReservationArguments(this.placeId, this.serviceTitle);
}
