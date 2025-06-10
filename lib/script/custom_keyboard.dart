import 'package:flutter/material.dart';
import 'package:speaky/asset/custom_keyboard_button.dart';
import 'package:speaky/page/home_page.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({super.key});

  static List<BlissKey> clickedKeyList = [];

  static List<BlissKey> getBlissKeyList() => clickedKeyList;
  static void resetblissKeyList() { 
    clickedKeyList.clear();
  }
  
 
  void addKeyPresed(BlissKey button) {
    clickedKeyList.add(button);
    homePageKey.currentState?.update();
  }

  void removeLastKeyPressed() {
    if (clickedKeyList.isNotEmpty) {
      clickedKeyList.removeLast();
      homePageKey.currentState?.update();
    }
  }

  //TODO add all bliss icons to the keyboard
  static final List<BlissKey> keyboardButons = [
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/Imemyself.png"),
      translation: 'je',
    ),
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/youyourself.png"),
      translation: 'tu',
    ),
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/hehimhimself.png"),
      translation: 'lui',
    ),
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/sheherherself.png"),
      translation: 'elle',
    ),
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/please.png"),
      translation: "s'il vous plaît",
    ),
    
    BlissKey(   //back button
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
      CustomKeyboard().removeLastKeyPressed();
      },
      buttonColor: const Color.fromARGB(255, 246, 189, 184),
      translation: 'retour',
    ),

    BlissKey(
      icon: Image.asset(""),
      translation: 'Love',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'House',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Find',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Adjust',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Photo',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Call',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Mail',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Secure',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Navigate',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Song',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Buy',
    ),
    BlissKey(
      icon: Image.asset(""),
      translation: 'Sky',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30, top: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: CustomKeyboard.keyboardButons.where((key)=> key.icon == "").toList() ,
      ),
    );
  }
}
