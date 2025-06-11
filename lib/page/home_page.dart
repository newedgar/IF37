import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:speaky/asset/custom_keyboard_button.dart';
import 'package:speaky/asset/list_item_container.dart';
import 'package:speaky/asset/list_view_container.dart';
import 'package:speaky/asset/main_container.dart';
import 'package:speaky/class/sentence_class.dart';
import 'package:speaky/manager/save_manager.dart';
import 'package:speaky/page/abreviation_page.dart';
import 'package:speaky/script/custom_keyboard.dart';
import 'package:speaky/script/synthese_vocale.dart';


GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: homePageKey);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  void update() {
    setState(() {});
  }

  TextEditingController sentenceInputController = TextEditingController();
  List<Sentence> sentencesList = SaveManager().getSentenceList();

  List<BlissSymbole> blissSymboleList = [];

  @override
  Widget build(BuildContext context) {
    blissSymboleList = CustomKeyboard.getBlissSymboleList();
    sentencesList = SaveManager().getSentenceList();
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child:  Padding(padding: EdgeInsets.all(5),child: Column(children: [
          Expanded(child: sentencesListView()),

          //Input sentence form field + save button + read button
          Padding(padding: EdgeInsets.all(10),child: 
            Row(children: [
              Expanded(child: sentenceInputFormField()),
              SizedBox(width: 10,),
              mainContainer(child: 
                Column(children: [
                  buttonSaveSentence(),
                  buttonReadSentence(),
                  buttonAbreviationPage(),
                ])
              )
              
            ],)
          ),

          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            height: MediaQuery.of(context).viewInsets.bottom > 10
                ? (MediaQuery.of(context).viewInsets.bottom - 200).clamp(0.0, double.infinity)
                : 0,
          ),
          
          //custom keyboard
            CustomKeyboard(key: ValueKey('custom_keyboard'))
        ]))
      )
    );
  }


  Widget sentencesListView() {

    return listViewContainer(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        itemCount: sentencesList.length,
        itemBuilder: (context, index) {
          return sentenceListItem(sentencesList[index]);
        },
        separatorBuilder: (context, index) => Divider(),
      )
    );
  }

  Widget sentenceListItem(Sentence sentence) {
    return listItemContainer(child: 
      Row(children: [
        Expanded(child: 
          AutoSizeText(sentence.sentence,maxLines: 3,)
        ),
        //read sentense button
        IconButton(
          icon: Icon(Icons.voice_chat),
          onPressed: () {
            setState(() {
              SyntheseVocale().speak(sentence.sentence);
            });
          },
        ),
        SizedBox(width: 10,),
        //Delet sentence button
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              SaveManager().removeSentenceFromSavedList(sentence);
            });
          },
        )
      ])
    );
  }


  Widget sentenceInputFormField() {
    ScrollController scrollController = ScrollController();

    return mainContainer(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [

        //normal input for native keyboard
        if (blissSymboleList.isEmpty)
        TextFormField(
          controller: sentenceInputController,
          decoration: InputDecoration(
            labelText: 'Enter a sentence',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                sentenceInputController.clear();
              },
            ),
          ),
          maxLines: 3,
          minLines: 3,
        ),


        //bliss input for custom keyboard
        if (blissSymboleList.isNotEmpty)
        Container(
          height: 100,
          width: double.infinity,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: Colors.transparent,
          ),
          child: Theme(
            data: ThemeData(
              highlightColor: const Color.fromARGB(255, 0, 0, 0), //Does not work
            ),
            child : Scrollbar ( 
              thumbVisibility: true,
              controller: scrollController,
              thickness: 3,
              
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 8.0,
                  children: CustomKeyboard.clickedKeyList.map((key) {
                    return  key.getIcon() ;
                  }).toList(),
                ),
              )
            )
          ),
        )
      ])

    );
  }



  ///Save the current sentence in the list of often sentences
  Widget buttonSaveSentence() {
    return GestureDetector(
      onTap: () {
        if (sentenceInputController.text.isNotEmpty) {
          SaveManager().addSentenceToSavedList(Sentence(sentence: replaceAbreviationByWord(sentenceInputController.text)));
          sentenceInputController.clear();
          setState(() {});
        }
        else if (blissSymboleList.isNotEmpty) {
          String translatedSentence = replaceBlissByWord();
          SaveManager().addSentenceToSavedList(Sentence(sentence: translatedSentence));
          CustomKeyboard.resetBlissSymboleList();
          setState(() {});
        }
      },
      child: Icon(Icons.save, size: 35,),
    );
  }

  ///Read the sentence or the bliss with the synthese vocal
  Widget buttonReadSentence() {
    return GestureDetector(
      onTap: () {
        if (sentenceInputController.text.isNotEmpty) {
          SyntheseVocale().speak(replaceAbreviationByWord(sentenceInputController.text));
        }
        if (blissSymboleList.isNotEmpty) {
          SyntheseVocale().speak(replaceBlissByWord());
        }
      },
      child: Icon(Icons.voice_chat, size: 35,),
    );
  }

  ///Go to abreviation page
  Widget buttonAbreviationPage() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AbreviationPage()));
      },
      child: Icon(Icons.abc_outlined, size: 35,),
    );
  }

  ///Replace bliss icons by equivalent words and return the sentence
  String replaceBlissByWord() {
    String translatedSentence = blissSymboleList.map((bliss) => bliss.translation).join(' ');
    
    return completeBlissWord(translatedSentence);
  } 


  ///Complete and replace some words in the sentence
  String completeBlissWord(String sentence) {
    sentence = sentence.replaceAll(RegExp(r'\bpossible je\b'), "puis-je");
    sentence = sentence.replaceAll(RegExp(r'\bpossible vous \b'), "pouvez vous");
    sentence = sentence.replaceAll(RegExp(r'\belle possible\b'), "peux-elle");
    sentence = sentence.replaceAll(RegExp(r'\bpossible elle\b'), "peux-elle");
    sentence = sentence.replaceAll(RegExp(r'\bil possible\b'), "peux-il");
    sentence = sentence.replaceAll(RegExp(r'\bpossible il\b'), "peux-il");
    sentence = sentence.replaceAll(RegExp(r'\baider je\b'), "m'aider");
    sentence = sentence.replaceAll(RegExp(r'\baider vous\b'), "vous aider");
    sentence = sentence.replaceAll(RegExp(r'\bpardon je\b'), "excusez-moi");
    sentence = sentence.replaceAll(RegExp(r'\btrouver pain\b'), "trouver du pain");
    sentence = sentence.replaceAll(RegExp(r'\baller vous\b'), "allez vous");
    


    //make first letter uppercase
    if (sentence.isNotEmpty) {
      sentence = sentence[0].toUpperCase() + sentence.substring(1);
    }

    //if no dot or question mark, add dot at the end
    if (!sentence.endsWith('.') && !sentence.endsWith('?')) {
      sentence += '.';
    }

    return sentence;
  } 

  ///Replace abreviation by the word corresponding and return the sentence
  String replaceAbreviationByWord(String sentence) {
    String newSentence = sentence;

    SaveManager().getAbreviationList().forEach((abreviation) {
      newSentence = newSentence.replaceAll(abreviation.abreviation, abreviation.word);
    });

    return newSentence;
  }


}