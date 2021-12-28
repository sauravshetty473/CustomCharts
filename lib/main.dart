import 'package:customcharts/homeRelated/home_page.dart';

import 'services/auth_stream.dart';
import 'package:customcharts/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase
      .initializeApp(); //necessary step before using any Firebase product //best place to do this(debatable) //make main async and await
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamProvider<User>.value(
          value: AuthService().user,
          child: HomePage(),
        ));
  }
}
