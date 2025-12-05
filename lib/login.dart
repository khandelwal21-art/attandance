import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/controller/login_controller.dart';
import 'package:location/widgets/custom_button.dart';
import 'package:location/widgets/custom_form_text_field.dart';
import 'attandance_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key
  });
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final LoginController controller=Get.find();
  final _formKey=GlobalKey<FormState>();

  bool _isVisible=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF00272E),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      // App name
                      children: [
                        Image.asset('assets/images/logo.png'),
                        CustomFormTextField(label: "Username",
                          controller: controller.emailController,
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
                            controller: controller.passwordController,
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
                              // if (value == null || value.isEmpty) {
                              //   return "Please enter a password.";
                              // }
                              //
                              // // At this point, Dart knows 'value' is a non-null string.
                              // if (value.length < 6) {
                              //   return "Password must be at least 6 characters long.";
                              // }


                              return null;
                            }
                        ),

                        //vertical spacing
                        SizedBox(height: 24,),

                        //Log in btn
                        Custombutton(btnText: "Log In ",
                          isPressed: () {
                            if(_formKey.currentState!.validate()){
                              controller.login();
                            }
                          },
                        ),


                      ],
                    ),
                  )),
            ),
          ),
        ],

      ),
    );

  }




}
