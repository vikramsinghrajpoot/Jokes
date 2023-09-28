import 'package:flutter/material.dart';
import 'package:news/presentation/pages/home_page.dart';
import 'package:news/util/db_manager/db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
