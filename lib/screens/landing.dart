import 'package:calc/domain/MyUser.dart';
import 'package:calc/screens/auth.dart';
import 'package:calc/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);
    final bool isLoggedIn = user != null;

  return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}