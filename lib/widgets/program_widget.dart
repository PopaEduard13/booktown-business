// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgramWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var program;

  ProgramWidget(this.program, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.lock_clock,
              size: 13,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Program :",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(children: [
          Text('Luni :'),
          Spacer(),
          Text(
              '${program['Luni']['Open'] as String} : ${program['Luni']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Marti :'),
          Spacer(),
          Text(
              '${program['Marti']['Open'] as String} : ${program['Marti']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Miercuri :'),
          Spacer(),
          Text(
              '${program['Miercuri']['Open'] as String} : ${program['Miercuri']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Joi :'),
          Spacer(),
          Text(
              '${program['Joi']['Open'] as String} : ${program['Joi']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Vineri :'),
          Spacer(),
          Text(
              '${program['Vineri']['Open'] as String} : ${program['Vineri']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Sambata :'),
          Spacer(),
          Text(
              '${program['Sambata']['Open'] as String} : ${program['Sambata']['Close'] as String}'),
        ]),
        SizedBox(height: 3),
        Row(children: [
          Text('Duminica :'),
          Spacer(),
          Text(
              '${program['Duminica']['Open'] as String} : ${program['Duminica']['Close'] as String}'),
        ]),
      ],
    );
  }
}
