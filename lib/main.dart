import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:if37/manager/save_manager.dart';
import 'package:if37/page/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Reverse Portrait
  ]);

  await SaveManager().loadLocalData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  //Here we launch the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage()
    );
  }
}

