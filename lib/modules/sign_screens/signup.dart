import 'package:flutter/material.dart';
import 'package:todo_app/modules/online_conect/widget.dart';
import 'package:todo_app/sherd/diohelper.dart';

import '../../sherd/const.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var check= validInput();

  GlobalKey<FormState> formKey = GlobalKey();
  HttpHelper httpHelper = HttpHelper();

  signUp(BuildContext context) async {
    if(formKey.currentState!.validate()){
      var response = await httpHelper.postRequest(linkSignup, {
        'username': userNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      if (response['status']=='Seccuss') {
        Navigator.pushNamedAndRemoveUntil(context,
          'notes', (route) => false,);
      }else
      {
        print('signup Fail');
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(physics: BouncingScrollPhysics(), children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/images/notes_logo.png',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        validator: (vale){
                          if(vale!.isEmpty){
                            return 'This field  must not be empty';

                          }
                          if(vale.length<3){
                            return 'This field must be more than 3 characters';

                          }if(vale.length>25){
                            return 'This field should must not be more than 12 characters ';

                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: userNameController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.purple[800]!,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          hintText: 'username',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple[200]!, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (vale){
                          if(vale!.isEmpty){
                            return 'This field  must not be empty';

                          }
                          if(vale.length<3){
                            return 'This field must be more than 3 characters';

                          }if(vale.length>30){
                            return 'This field should must not be more than 12 characters ';

                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.purple[800]!,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple[200]!, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (vale){
                          if(vale!.isEmpty){
                            return 'This field  must not be empty';

                          }
                          if(vale.length<3){
                            return 'This field must be more than 3 characters';

                          }if(vale.length>30){
                            return 'This field should must not be more than 12 characters ';

                          }                      },
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.purple[800]!,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple[200]!, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: ()async {
                         await signUp(context);
                        },
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'SignUp',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.purple,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                        //color: Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
