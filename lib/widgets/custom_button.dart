import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget{
  final String btnText;
  bool isLoading;
  final VoidCallback isPressed;

  Custombutton({
    required this.btnText,
    required this.isPressed,
    this.isLoading=false
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:52.0,
      child: ElevatedButton(onPressed:!isLoading?isPressed:null,
        style: ButtonStyle(
          shape:WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: Colors.grey
                )
              )
          ),
          backgroundColor:WidgetStatePropertyAll(Color(0xFF00272E)),

        ),
        child: isLoading?
        SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ):
        Text(btnText,style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey

        ),
        ),
      ),
    );
  }

}