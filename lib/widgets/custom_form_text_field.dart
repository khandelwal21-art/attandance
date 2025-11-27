import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget{
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;


  const CustomFormTextField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText=false,
    this.keyboardType=TextInputType.text,
    required this.validator

  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color:Colors.grey,

        ),),
        SizedBox(height: 10,),
        TextFormField(
          controller:controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration:InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            // text form field border
            border:
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.white,
              ) ,
            ),

            //enabled border
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 2
                )
            ),
          ),

        )
      ],
    );

  }

}