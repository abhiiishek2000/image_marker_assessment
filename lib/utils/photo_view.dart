import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatefulWidget {
  const PhotoViewWidget({Key? key,required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  State<PhotoViewWidget> createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PhotoView(
        imageProvider: NetworkImage(widget.imgUrl),
      ),
    );
  }
}
