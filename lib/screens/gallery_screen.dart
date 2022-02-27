import 'package:flutter/material.dart';

import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/GalleryScreen';

  const GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final urlImages =
        ModalRoute.of(context).settings.arguments as List<dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Galerie Foto",
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: urlImages.length,
        builder: (ctx, i) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(urlImages[i]),
          );
        },
      ),
    );
  }
}
