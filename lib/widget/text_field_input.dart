import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextInput({super.key, required this.textEditingController, required this.isPass, required this.hintText, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      
      borderSide: Divider.createBorderSide(context)
    );
    return TextField(
         style: TextStyle(
          color: Colors.black
         ),
          controller: textEditingController,
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 247, 245, 245),
            hintText: hintText,
            
            hintStyle: TextStyle(color: Colors.black),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: EdgeInsets.all(8)
          ),
          keyboardType: textInputType,
          obscureText: isPass,
    );
  }
}