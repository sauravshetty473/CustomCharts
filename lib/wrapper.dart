import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/loginScreen.dart';
import 'homeRelated/home.dart';

class Wrapper extends StatelessWidget  {
  @override
  Widget build(BuildContext context){

    final user = Provider.of<User>(context);

    return user==null||user.phoneNumber==null?LoginScreen(): Home();
  }
}


