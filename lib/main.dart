import 'package:customcharts/homeRelated/home.dart';
import 'package:customcharts/homeRelated/load_record.dart';
import 'package:customcharts/recordRelated/allRecords.dart';
import 'package:customcharts/services/authRelated.dart';
import 'homeRelated/record.dart';
import 'package:customcharts/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();                                               //necessary step before using any Firebase product //best place to do this(debatable) //make main async and await
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(

            accentColor: Colors.transparent,


            appBarTheme: AppBarTheme(
              backgroundColor:  Color.fromARGB(255,0,133,166),
            )
        ),


        debugShowCheckedModeBanner: false,
        home: true?Home():StreamProvider<User>.value(
          value: AuthService().user,
          child: Wrapper(),
        )
    );
  }
}
