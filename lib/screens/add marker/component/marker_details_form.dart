import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_marker/data/firebase/firebase_service.dart';
import 'package:provider/provider.dart';
import '../../../utils/custom_textfield.dart';

class MarkerDetailsForm extends StatefulWidget {
  const MarkerDetailsForm({Key? key,required this.imgFile,required this.id,required this.oldImgUrl}) : super(key: key);
  final File imgFile;
  final String id;
  final String oldImgUrl;

  @override
  State<MarkerDetailsForm> createState() => _MarkerDetailsFormState();
}

class _MarkerDetailsFormState extends State<MarkerDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _markdes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<FirebaseService>(builder: (context,provider,child){
        return provider.isLoading ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Uploading....')
          ],
        )): Form(
          key: _formKey,
          child: Column(
            children: [
              customTextFormField(
                  controller:_markdes,
                  hinttext: 'Write Marker Description',
                  inputtype: TextInputType.text,
                  maxligne: 5,
                  onvalidate: (value){
                    if (value!.isEmpty){
                      return "Field is Required";
                    }
                  }

              ),

              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  Provider.of<FirebaseService>(context,listen: false).addMartData(context:context,imageFile: widget.imgFile, markDes: _markdes.text,id: widget.id,oldImg: widget.oldImgUrl);
                }
              }, child: Text("Upload"))
            ],
          ),
        );
      }),
    );
  }
}
