import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_marker/data/model/marker_details_model.dart';
import 'package:image_marker/screens/home/home_screen.dart';

class FirebaseService with ChangeNotifier{
  bool isLoading =false;
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference markerImages =
  FirebaseFirestore.instance.collection('marker images');
  Map<String, dynamic> markerImageList = Map();


  void loading(){
    isLoading =true;
    notifyListeners();
  }
  void notLoading(){
    isLoading =false;
    notifyListeners();
  }

  Future<void> uploadData({required BuildContext context,required File imageFile,required String name, required String des}) async {
    Random random =  Random();
    int randomNumber = random.nextInt(900) + 100;
    try {
      loading();
      await storage.ref().child('imagemarker$randomNumber').putFile(
        imageFile,
      );
      notLoading();
      String downloadURL =
      await FirebaseStorage.instance.ref("imagemarker$randomNumber").getDownloadURL();
      addMarkerDetails(context,MarkerDetails(name: name, des: des, imgUrl: downloadURL, createdAt: "${DateTime.now()}", updatedAt: "${DateTime.now()}"));
    } on FirebaseException catch (error) {
      notLoading();
      print(error);
      Fluttertoast.showToast(msg: "Something Went Wrong!");
    }
  }

  Future<void> addMarkerDetails(BuildContext context,MarkerDetails markerDetails) async {
  try{
   await markerImages.add(
        markerDetails.toJson()
    ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())));

  } on FirebaseException catch (error) {
    notLoading();
    print(error);
    Fluttertoast.showToast(msg: "Something Went Wrong!");
  }
  }
  
  Future<void> getData() async{
    try{
      await markerImages.get().then((value) => null);
    } on FirebaseException catch (error) {
      notLoading();
      print(error);
      Fluttertoast.showToast(msg: "Something Went Wrong!");
    }
  }
  Future<void> addMartData({required BuildContext context,required String id, required File imageFile, required String markDes,required String oldImg}) async{
    Random random =  Random();
    int randomNumber = random.nextInt(900) + 100;
    try {
      loading();
      await storage.ref().child('imagemarker$randomNumber').putFile(
        imageFile,
      );

      String downloadURL =
      await FirebaseStorage.instance.ref("imagemarker$randomNumber").getDownloadURL();
      await FirebaseStorage.instance.refFromURL(oldImg).delete();
      notLoading();
      await markerImages.doc(id).update({
        'imgUrl': downloadURL,
        'markDes': markDes,
        'isMark': true,
      }).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())));
      
    } on FirebaseException catch (error) {
      notLoading();
      print(error);
      Fluttertoast.showToast(msg: "Something Went Wrong!");
    }
  }

}