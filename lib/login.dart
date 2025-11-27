import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/widgets/custom_button.dart';
import 'package:location/widgets/custom_form_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key
  });
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  bool _isVisible=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF00272E),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(
                    maxWidth: 440.0
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color:Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),

                      ),
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              // App name
                              children: [
                                Text("Login",
                                   style: TextStyle(
                                     fontSize: 35,
                                     fontWeight: FontWeight.bold,
                                     color:Colors.grey,
                                   ),

                                 ),


                                // SizedBox(height: 48                ,),
                                CustomFormTextField(label: "Username",
                                  controller: _emailController,
                                  validator: (value){
                                    if( value==null||value.isEmpty){
                                      return "please enter email";
                                    }
                                    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.(com|org)$");
                                    if(!emailRegExp.hasMatch(value) ){
                                      return "Please enter a valid email address.";
                                    }
                                    return null;
                                  },


                                  prefixIcon: Icon(Icons.email,color:Colors.white,),),
                                const SizedBox(height: 24),

                                CustomFormTextField(label: "Password",
                                    controller: _passwordController,
                                    obscureText: !_isVisible,
                                    prefixIcon: Icon(Icons.lock,color:Colors.white,),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isVisible? Icons.visibility:Icons.visibility_off,),
                                      onPressed: (){
                                        setState((){
                                          _isVisible=!_isVisible;
                                        });

                                      },
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a password.";
                                      }

                                      // At this point, Dart knows 'value' is a non-null string.
                                      if (value.length < 6) {
                                        return "Password must be at least 6 characters long.";
                                      }


                                      return null;
                                    }
                                ),

                                //vertical spacing
                                SizedBox(height: 24,),

                                //Log in btn
                                Custombutton(btnText: "Log In ",
                                  isPressed: () {
                                    if(_formKey.currentState!.validate()){

                                    }
                                  },
                                ),


                              ],
                            ),
                          ))
                  ),
                ),

              ),
            ),
          ),
        ],

      ),
    );

  }




}
