import 'package:flutter/material.dart';
import 'package:if37/asset/custom_keyboard_button.dart';
import 'package:if37/page/home_page.dart';

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
    BlissKey(
      icon: Image.asset("assets/icons/keyboard/youyourself.png"),
      translation: 'tu',
    ),
    
    BlissKey(   //back button
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
      CustomKeyboard().removeLastKeyPressed();
      },
      buttonColor: const Color.fromARGB(255, 246, 189, 184),
      translation: 'Back',
    ),

    BlissKey(
      icon: const Icon(Icons.favorite),
      translation: 'Love',
    ),
    BlissKey(
      icon: const Icon(Icons.home),
      translation: 'House',
    ),
    BlissKey(
      icon: const Icon(Icons.search),
      translation: 'Find',
    ),
    BlissKey(
      icon: const Icon(Icons.settings),
      translation: 'Adjust',
    ),
    BlissKey(
      icon: const Icon(Icons.camera),
      translation: 'Photo',
    ),
    BlissKey(
      icon: const Icon(Icons.phone),
      translation: 'Call',
    ),
    BlissKey(
      icon: const Icon(Icons.email),
      translation: 'Mail',
    ),
    BlissKey(
      icon: const Icon(Icons.lock),
      translation: 'Secure',
    ),
    BlissKey(
      icon: const Icon(Icons.map),
      translation: 'Navigate',
    ),
    BlissKey(
      icon: const Icon(Icons.music_note),
      translation: 'Song',
    ),
    BlissKey(
      icon: const Icon(Icons.shopping_cart),
      translation: 'Buy',
    ),
    BlissKey(
      icon: const Icon(Icons.cloud),
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
        children: CustomKeyboard.keyboardButons,
      ),
    );
  }
}
