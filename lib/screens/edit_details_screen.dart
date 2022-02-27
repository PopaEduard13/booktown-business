// ignore_for_file: unnecessary_const, prefer_final_fields

import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class EditDetailsScreen extends StatefulWidget {
  const EditDetailsScreen({Key key}) : super(key: key);
  static const routeName = "/EditDetailsScreen";

  @override
  _EditDetailsScreenState createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  TextEditingController _title = TextEditingController();
  // TextEditingController _lastName = TextEditingController();
  // TextEditingController _phone = TextEditingController();
  // TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Editeaza datele locatiei tale",
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Denumirea locatiei :",
                ),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Descrierea locatiei :",
                ),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Adresa :",
                ),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Numar de contact :",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 100,
              child: TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Denumirea locatiei :",
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Text(
                "Program",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Luni :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Marti :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Miercuri :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Joi :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Vineri :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Sambata :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Duminica :",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Deschidere",
                    ),
                  ),
                ),
                const Text("-"),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: "Inchidere",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
