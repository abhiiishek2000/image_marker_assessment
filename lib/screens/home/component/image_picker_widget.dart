import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_marker/screens/add%20marker/add_marker.dart';
import 'package:image_marker/screens/add%20marker/component/marker_details_form.dart';
import 'package:image_marker/screens/home/component/add_details_form.dart';
import 'package:image_marker/utils/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicketWidget extends StatefulWidget {
  const ImagePicketWidget({Key? key}) : super(key: key);

  @override
  State<ImagePicketWidget> createState() => _ImagePicketWidgetState();
}

class _ImagePicketWidgetState extends State<ImagePicketWidget> {
  final picker = ImagePicker();
  File? _imageFile;


  Future pickImage({bool fromCamera = false}) async {
    final pickedFile =
    await picker.pickImage(source: fromCamera ? ImageSource.camera: ImageSource.gallery, imageQuality: 25);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });

   if(_imageFile !=null){
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMarkerScreen(sourceImage: _imageFile!)));
     showModalBottomSheet(
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
         ),
         context: context,
         builder: (context)=> AddDetailsForm(imgFile: _imageFile!,));
   }else{
     showSnackBar(context: context, message: 'Something went wrong!', isError: true);
   }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Container(
         margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
         width: double.infinity,
           height: 54,
           child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                elevation: MaterialStateProperty.all(0.0)
              ),
               onPressed: () async =>choosePickerOption(), icon: const Icon(Icons.upload),
               label: const Text('Upload Image')))
      ],
    );
  }

    choosePickerOption() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
        ),
        context: context, builder: (context){
      return SizedBox(
        height: 160,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Choose option",style: Theme.of(context).textTheme.headline6,),
            ListTile(
              onTap: ()=>pickImage(fromCamera: true),
              title: Text('Camera',style:Theme.of(context).textTheme.bodyText1),
              leading: const Icon(Icons.camera,color: Colors.black,),
            ),
            ListTile(
              onTap: ()=>pickImage(fromCamera: false),
              title: Text('Gallery',style:Theme.of(context).textTheme.bodyText1),
              leading: const Icon(Icons.image,color: Colors.black),
            ),
          ],
        ),
      );
    });
  }
}
