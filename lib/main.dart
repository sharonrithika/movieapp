import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/movielist.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieapp/home.dart';
//import 'package:firebase_core/firebase_core.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MovieListAdapter());
  await Hive.openBox<MovieList>('watchlist');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
       debugShowCheckedModeBanner: false,
         //title: title,
         theme: ThemeData(primarySwatch: Colors.indigo),
         home: Home(),
    );
  }
}
