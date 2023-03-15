import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modules/online_conect/notes_screen.dart';
import 'package:todo_app/modules/sign_screens/login.dart';
import 'package:todo_app/modules/sign_screens/signup.dart';

import 'modules/online_conect/Online_add_screen.dart';
late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences= await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: sharedPreferences.getString('id')!=null?'notes':'login',
      routes: {
        'login':(context) => LoginScreen(),
        'signup':(context) => SignUpScreen(),
        'notes':(context) => OnlineNotesPage(),
        'add':(context) => OnlineAddNotePage(),
        'edite':(context) => OnlineNotesPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.purple,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),

    );
  }
}


