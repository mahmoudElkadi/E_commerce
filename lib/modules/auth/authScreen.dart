import 'package:e_commerce_app/commponent/common/reusableWidget.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth{
  signin,
  signup
}

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth auth=Auth.signup;
  final AuthServices authServices=AuthServices();
  final signUpGlobalKey=GlobalKey<FormState>();
  final signInGlobalKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  IconData suffix=Icons.remove_red_eye;

  bool obscureText = true;

  void signUpUser(){
    authServices.signUpUser(context: context, userName: nameController.text, email: emailController.text, password: passwordController.text);
  }

  void signInUser(){
    authServices.signInUser(context: context, email: emailController.text, password: passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),
              ),
              ListTile(
                tileColor: auth==Auth.signup ? GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
                title: Text('Create Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value:Auth.signup ,
                  groupValue: auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      auth=value!;
                    });
                  },

                ),
              ),
              if(auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(10),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: signUpGlobalKey,
                    child: Column(
                      children: [
                         defaultTextFormField(controller: nameController,
                             type: TextInputType.name,
                             label: "UserName",
                             prefixIcon: Icons.person,
                             kind: 'UserName'),
                        SizedBox(height: 10,),defaultTextFormField(controller: emailController,
                            type: TextInputType.emailAddress,
                            label: "Email",
                            prefixIcon: Icons.email,
                            kind: 'Email'),
                        SizedBox(height: 10,),
                        defaultTextFormField(controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: "Password",
                            prefixIcon: Icons.lock,
                            kind: 'password',
                            suffixIcon: suffix,
                            showPass: (){
                              setState(() {
                                obscureText= !obscureText;
                                suffix=obscureText ? Icons.visibility_off:Icons.remove_red_eye;
                              });
                            },
                          isPass: obscureText,
                        ),
                        SizedBox(height: 10,),

                        defaultButton(background:GlobalVariables.secondaryColor, text:"sign up",
                            onpressed: (){
                              if(signUpGlobalKey.currentState!.validate()){
                                signUpUser();
                              }
                            }),
                      ],
                    ),

                  ),
                ),

              ListTile(
                tileColor: auth==Auth.signin ? GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
                title: Text('Sign-in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value:Auth.signin ,
                  groupValue: auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      auth=value!;
                    });
                  },

                ),
              ),
              if(auth==Auth.signin)
              Container(
                padding: EdgeInsets.all(10),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: signInGlobalKey,
                  child: Column(
                    children: [

                      defaultTextFormField(controller: emailController,
                          type: TextInputType.emailAddress,
                          label: "Email",
                          prefixIcon: Icons.email,
                          kind: 'Email'),
                      SizedBox(height: 10,),
                      defaultTextFormField(controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: "Password",
                        prefixIcon: Icons.lock,
                        kind: 'password',
                        suffixIcon: suffix,
                        showPass: (){
                          setState(() {
                            obscureText= !obscureText;
                            suffix=obscureText ? Icons.visibility_off:Icons.remove_red_eye;
                          });
                        },
                        isPass: obscureText,
                      ),
                      SizedBox(height: 10,),

                      defaultButton(background:GlobalVariables.secondaryColor, text:"sign in", onpressed: (){
                        if(signInGlobalKey.currentState!.validate()){
                          signInUser();
                        }
                      }),
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
