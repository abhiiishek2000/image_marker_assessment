import 'package:flutter/material.dart';


Widget customTextFormField(
    {required TextEditingController controller,
      required TextInputType inputtype,
      Function(String?)? onfieldsubmit,
      VoidCallback? ontap,
      String? Function(String?)? onvalidate,
      Function(String?)? onchange,
      String? text,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscure = false,
      String? hinttext,
      int? maxligne,
      int? maxLength,
      bool readonly = false}) =>
    TextFormField(
        controller: controller,
        keyboardType: inputtype,
        onFieldSubmitted: onfieldsubmit,
        onTap: ontap,
        maxLength: maxLength,
        maxLines: maxligne ?? 1,
        readOnly: readonly,
        obscureText: obscure,
        onChanged: onchange,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: text,
          hintText: hinttext,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'regular'
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  const BorderSide(color:Colors.indigo,width: 1.5)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  const BorderSide(color:Colors.indigo,width: 0.5)),
        ),
        validator: onvalidate);