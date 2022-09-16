import 'package:flutter/material.dart';

import 'component/image_list_widget.dart';
import 'component/image_picker_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text("Image Marker"),
        ),
      body: Column(
        children: const [
          ImagePicketWidget(),
          ImageListWidget()
        ],
      ),
    );
  }
}
