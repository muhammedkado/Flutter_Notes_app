import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/sherd/const.dart';
import 'package:todo_app/sherd/diohelper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  HttpHelper httpHelper = HttpHelper();

  login(context) async {
    if (formKey.currentState!.validate()) {
      try {
        var respons = await httpHelper.postRequest(linkLogin, {
          'email': emailController.text,
          'password': passwordController.text,
        });
        if (respons['status'] == 'Seccuss') {
          Navigator.pushNamedAndRemoveUntil(context, 'notes', (route) => false);
          sharedPreferences.setString('id', respons['data']['id'].toString());
          sharedPreferences.setString('username', respons['data']['username']);
          sharedPreferences.setString('email', respons['data']['email']);
        } else {
          AwesomeDialog(
              context: context,
              title: 'Worning',
              desc: 'Pleas check your email or password')
            ..show();
        }
      } catch (e) {
        AwesomeDialog(context: context, title: 'Error', desc: '$e')..show();
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
                        validator: (vale) {
                          if (vale!.isEmpty) {
                            return 'This field  must not be empty';
                          }
                          if (vale.length < 3) {
                            return 'This field must be more than 3 characters';
                          }
                          if (vale.length > 25) {
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
                        validator: (vale) {
                          if (vale!.isEmpty) {
                            return 'This field  must not be empty';
                          }
                          if (vale.length < 3) {
                            return 'This field must be more than 3 characters';
                          }
                          if (vale.length > 25) {
                            return 'This field should must not be more than 12 characters ';
                          }
                        },
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
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onPressed: () {
                          login(context);
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.purple,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                        child: Text(
                          'SignUp',
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
