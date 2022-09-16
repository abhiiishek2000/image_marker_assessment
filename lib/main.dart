import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_marker/data/firebase/firebase_service.dart';
import 'package:image_marker/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(ChangeNotifierProvider(create: (context)=>FirebaseService(),child: const MyApp()));
  });
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Marker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}


