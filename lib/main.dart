import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'page/page1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory =  await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Page1(),
    );
  }
}
