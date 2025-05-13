import 'package:flutter/material.dart';
import 'package:if37/asset/custom_keyboard_button.dart';
import 'package:if37/page/home_page.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({super.key});

  static List<CustomKeyboardButton> clickedKeyList = [];

  static addKeyPresed(CustomKeyboardButton button) {
    clickedKeyList.add(button);
    print(clickedKeyList.toString());
  }

  static removeLastKeyPressed() {
    if (clickedKeyList.isNotEmpty) {
      clickedKeyList.removeLast();
    }
  }


  static final List<CustomKeyboardButton> keyboardButons = [
    CustomKeyboardButton(
      icon: const Icon(Icons.check),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.close),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.add),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.remove),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.star),
    ),
    CustomKeyboardButton(   //back button
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        CustomKeyboard.removeLastKeyPressed();
        //TODO  make homepage update
        homePageKey.currentState?.update();
      },
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.favorite),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.home),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.search),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.settings),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.camera),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.phone),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.email),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.lock),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.map),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.music_note),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.shopping_cart),
    ),
    CustomKeyboardButton(
      icon: const Icon(Icons.cloud),
    ),
  ];


  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30, top: 10), 
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: CustomKeyboard.keyboardButons
      )
    );
  }
}