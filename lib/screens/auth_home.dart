import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/auth.dart';
import 'package:gerencimento_estado/screens/ScreenScreen.dart';
import 'package:gerencimento_estado/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return auth.isAuth ? MainScreen() : AuthScreen();
  }
}
