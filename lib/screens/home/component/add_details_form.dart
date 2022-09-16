import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_marker/data/firebase/firebase_service.dart';
import 'package:provider/provider.dart';
import '../../../utils/custom_textfield.dart';

class AddDetailsForm extends StatefulWidget {
  const AddDetailsForm({Key? key,required this.imgFile}) : super(key: key);
  final File imgFile;

  @override
  State<AddDetailsForm> createState() => _AddDetailsFormState();
}

class _AddDetailsFormState extends State<AddDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
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
                  controller:_name,
                  hinttext: 'Name',
                  inputtype: TextInputType.text,
                  onvalidate: (value){
                    if (value!.isEmpty){
                      return "Name is Required";
                    }
                  }

              ),
              SizedBox(height: 16),
              customTextFormField(
                controller:_description,
                hinttext: 'Description',
                maxligne: 5,
                inputtype: TextInputType.text,


              ),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  Provider.of<FirebaseService>(context,listen: false).uploadData(context:context,imageFile: widget.imgFile, name: _name.text, des: _description.text);
                }
              }, child: Text("Upload"))
            ],
          ),
        );
      }),
    );
  }
}
