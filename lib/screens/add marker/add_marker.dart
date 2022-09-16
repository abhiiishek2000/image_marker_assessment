import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/firebase/firebase_service.dart';
import 'component/marker_details_form.dart';

class AddMarkerScreen extends StatefulWidget {
  const AddMarkerScreen({Key? key,required this.sourceImage,required this.id}) : super(key: key);
  final String sourceImage;
  final String id;

  @override
  State<AddMarkerScreen> createState() => _AddMarkerScreenState();
}

class _AddMarkerScreenState extends State<AddMarkerScreen> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Mark Into Image"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () async{
              setState(() {
                isLoading =true;
              });
              final image = await _imageKey.currentState?.exportImage();
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/image.png').create();
              file.writeAsBytesSync(image!);
              setState(() {
                isLoading =false;
              });
               showModalBottomSheet(
                   shape: const RoundedRectangleBorder(
                     borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                   ),
                   context: context,
                   builder: (context)=> MarkerDetailsForm(imgFile: file,id: widget.id,oldImgUrl: widget.sourceImage,));
            },
          )
        ],
      ),
      body: isLoading ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Preparing Image....')
        ],
      )): ImagePainter.network(
        widget.sourceImage,
        key: _imageKey,
        scalable: true,
        initialStrokeWidth: 2,
        initialColor: Colors.green,
        initialPaintMode: PaintMode.freeStyle,
      ),
    );
  }
}
