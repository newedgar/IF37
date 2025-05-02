import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:if37/asset/list_item_container.dart';
import 'package:if37/asset/list_view_container.dart';
import 'package:if37/asset/main_container.dart';
import 'package:if37/class/sentence_class.dart';
import 'package:if37/manager/save_manager.dart';
import 'package:if37/script/synthese_vocale.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController sentenceInputController = TextEditingController();
  List<Sentence> sentencesList = SaveManager().getSentenceList();


  @override
  Widget build(BuildContext context) {
    sentencesList = SaveManager().getSentenceList();
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(padding: EdgeInsets.all(5),child: Column(children: [
        Expanded(child: sentencesListView()),

        Padding(padding: EdgeInsets.all(10),child: 
          Row(children: [
            Expanded(child: sentenceInputFormField()),
            SizedBox(width: 10,),
            Column(children: [
              buttonSaveSentence(),
              buttonReadSentence(),
            ],)
            
          ],)
        ),
      ]))
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
    return mainContainer(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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
    );
  }



  ///Save the current sentence in the list of often sentences
  Widget buttonSaveSentence() {
    return ElevatedButton(
      onPressed: () {
        if (sentenceInputController.text.isEmpty) return;

        SaveManager().addSentenceToSavedList(Sentence(sentence: sentenceInputController.text));
        sentenceInputController.clear();
        setState(() {});
      },
      child: Icon(Icons.save),
    );
  }

  ///Read the sentence with the synthese vocal
  Widget buttonReadSentence() {
    return ElevatedButton(
      onPressed: () {
        SyntheseVocale().speak(sentenceInputController.text);
      },
      child: Icon(Icons.voice_chat),
    );
  }


}