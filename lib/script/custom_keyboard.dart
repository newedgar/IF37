import 'package:flutter/material.dart';
import 'package:speaky/asset/custom_keyboard_button.dart';
import 'package:speaky/page/home_page.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({super.key});

  static List<BlissSymbole> clickedKeyList = [];

  static List<BlissSymbole> getBlissSymboleList() => clickedKeyList;
  static void resetBlissSymboleList() { 
    clickedKeyList.clear();
  }
  
 
  void addKeyPresed(BlissSymbole button) {
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
  static final List<BlissSymbole> keyboardButons = [
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/Imemyself.png",width: 40,height: 40,),
      translation: 'je',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/youyourself.png",width: 40,height: 40,),
      translation: 'vous',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/hehimhimself.png",width: 40,height: 40,),
      translation: 'lui',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/sheherherself.png",width: 40,height: 40,),
      translation: 'elle',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/please.png",width: 40,height: 40,),
      translation: "s'il vous plaît",
    ),
    
    BlissSymbole(   //back button
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
      CustomKeyboard().removeLastKeyPressed();
      },
      buttonColor: const Color.fromARGB(255, 246, 189, 184),
      translation: 'retour',
    ),

    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/Good_morning_(hello).png",width: 40,height: 40,),
      translation: 'bonjour',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/how.png",width: 40,height: 40,),
      translation: 'comment',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/be,am,are,is,exist-(to).png",width: 40,height: 40,),
      translation: 'aller',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/find-(to).png",width: 40,height: 40,),
      translation: 'trouver',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/possible.png",width: 40,height: 40,),
      translation: 'possible',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/question_mark.png",width: 40,height: 40,),
      translation: '?',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/help,aid,assist,serve,support-(to).png",width: 40,height: 40,),
      translation: 'aider',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/bread,loaf_of_bread,loaf.png",width: 40,height: 40,),
      translation: 'pain',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/where.png",width: 40,height: 40,),
      translation: 'où',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/problem.png",width: 40,height: 40,),
      translation: 'problème',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/excuse.png",width: 40,height: 40,),
      translation: 'pardon',
    ),
    BlissSymbole(
      icon: Image.asset("assets/icons/keyboard/comma.png",width: 35,height: 35,),
      translation: ',',
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
