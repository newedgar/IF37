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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  
  void changePage(Widget page) {
    _MyAppState().changePage(page);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget currentPage = HomePage();

  void changePage(Widget page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: HomePage(),
      )
    );
  }
}
