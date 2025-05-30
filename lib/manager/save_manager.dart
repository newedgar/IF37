import 'dart:convert';

import 'package:if37/class/abreviation_class.dart';
import 'package:if37/class/sentence_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  //make the SaveManager class a singleton , only crete one time
  static final SaveManager _instance = SaveManager._internal();
  // Step 2: Private constructor
  SaveManager._internal();
  // Step 3: Factory constructor
  factory SaveManager() {
    return _instance;
  }

  List<Sentence> sentenceList = [];
  List<Abreviation> abreviationList = [];


  //setters and getters

  ///Add a sentence to the list of often used sentences
  void addSentenceToSavedList(Sentence sentence) {
    sentenceList.add(sentence);
    saveSentenceList();
  }

  void removeSentenceFromSavedList(Sentence sentence) {
    sentenceList.remove(sentence);
    saveSentenceList();
  }

  List<Sentence> getSentenceList() => sentenceList;


  ///Add an abbreviation to the list of abbreviations
  void addAbreviationToSavedList(Abreviation abreviation) {
    abreviationList.add(abreviation);
    saveAbreviationList();
  }

  void removeAbreviationFromSavedList(Abreviation abreviation) {
    abreviationList.remove(abreviation);
    saveAbreviationList();
  }

  void setAbreviationList(List<Abreviation> newList) {
    abreviationList = newList;
    saveAbreviationList();
  }

  List<Abreviation> getAbreviationList() => abreviationList;
 
  //save method

  ///Save all sentences to shared preferences
  saveSentenceList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = sentenceList.map((sentence) => jsonEncode(sentence.toJson())).toList();
    await prefs.setStringList('savedSentences', encodedList);
  }

  ///Save all abbreviations to shared preferences
  saveAbreviationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = abreviationList.map((abreviation) => jsonEncode(abreviation.toJson())).toList();
    await prefs.setStringList('savedAbreviations', encodedList);
  }

  //load method
  ///Load all the thing saved in the shared preferences
  ///This method is called when the app starts
  ///Call all methods that need to load something
  loadLocalData() async{
    await loadSentenceList();
    await loadAbreviationList();

  }


  ///Load all saved sentences from shared preferences
  loadSentenceList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('savedSentences');
    if (encodedList != null) {
      sentenceList = encodedList.map((sentence) => Sentence.fromJson(jsonDecode(sentence))).toList();
    } else {
      sentenceList = [];
    }
  }

  ///Load all saved sentences from shared preferences
  loadAbreviationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('savedAbreviations');
    if (encodedList != null) {
      abreviationList = encodedList.map((abreviation) => Abreviation.fromJson(jsonDecode(abreviation))).toList();
    } else {
      abreviationList = [];
    }
  }
  

}