import 'package:calc/domain/MyUser.dart';
import 'package:calc/screens/landing.dart';
import 'package:calc/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FitApp());
}


class FitApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
    value: AuthService().currentUser,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ajax Fitness App',
          theme: ThemeData(
          primaryColor: Color.fromRGBO(50, 65, 85, 1),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
      ),
      home: LandingPage(),
    )
    );
  }
}

