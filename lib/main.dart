// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import './screens/main_screen.dart';
import './screens/place_details_screen.dart';
import './screens/reservations_screen.dart';
import './screens/gallery_screen.dart';
import './screens/menu_screen.dart';
import './screens/edit_details_screen.dart';
// import './screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: const Color(0xffEFE6DD)),
        ),
        primaryColor: const Color(0xffEFE6DD),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffFFFFFF),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        ReservationsScreen.routeName: (ctx) => ReservationsScreen(),
        GalleryScreen.routeName: (ctx) => GalleryScreen(),
        MenuScreen.routeName: (ctx) => MenuScreen(),
        EditDetailsScreen.routeName: (ctx) => EditDetailsScreen(),
      },
    );
  }
}
