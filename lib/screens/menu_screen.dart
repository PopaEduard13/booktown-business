import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import './place_details_screen.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/MenuScreen';

  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as MenuArguments;
    final menuPics = args.menuPics;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meniu"),
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: menuPics.length,
        builder: (ctx, i) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(menuPics[i]),
          );
        },
      ),
    );
  }
}
