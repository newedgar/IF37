


import 'package:flutter/material.dart';
import 'package:speaky/asset/list_item_container.dart';
import 'package:speaky/asset/list_view_container.dart';
import 'package:speaky/asset/main_container.dart';
import 'package:speaky/class/abreviation_class.dart';
import 'package:speaky/manager/save_manager.dart';



class AbreviationPage extends StatefulWidget {
  const AbreviationPage({super.key});

  @override
  State<AbreviationPage> createState() => AbreviationPageState();
}

class AbreviationPageState extends State<AbreviationPage> {
  List<Abreviation> abreviationsList = SaveManager().getAbreviationList();
  final FocusNode _searchForcus = FocusNode();
  final TextEditingController _searchBarControler = TextEditingController();
  String searchString = "";

  List<Abreviation> filteredAbreviations = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(padding: EdgeInsets.all(10),child: 
          Column(children: [
            Container(
              height: 80,
              padding: EdgeInsets.all(10),
              child: 
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      SaveManager().setAbreviationList(abreviationsList);
                      Navigator.pop(context);
                    },
                    child: mainContainer(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Icon(Icons.abc_outlined, size: 50),
                      )
                    ),
                  ),
                  searchBar(),
                ]),
            ),

            Expanded(child: listViewContainer(child: 
              ListView.builder(
                itemCount: abreviationsList.length +1,
                itemBuilder: (context, index) {
                  if (index == abreviationsList.length) {
                    return addRemoveAbreviationItem();
                  } else {
                    Abreviation abreviation = abreviationsList[index];
                    if (searchString.isNotEmpty && !abreviation.abreviation.toLowerCase().contains(searchString.toLowerCase()) && !abreviation.word.toLowerCase().contains(searchString.toLowerCase())) {
                      return SizedBox.shrink(); // Skip this item if it doesn't match the search
                    }
                    return abreviationItem(index);
                  }
                  
                }
              )
            ))
          ])
        )
      )
    );
  }

  abreviationItem(int index) {
    return Padding(padding: EdgeInsets.all(10),child:  listItemContainer(child: 
      Row(children: [
        abreviationTextField(index),
        SizedBox(width: 10),
        wordTextField(index)
      ])
    ));
  }

  addRemoveAbreviationItem() {
    return Padding(padding: EdgeInsets.all(10),child: 
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (abreviationsList.isEmpty) return; // Prevent removing if the list is empty
              
              setState(() {
                SaveManager().removeAbreviationFromSavedList(abreviationsList.last);
              });
            }, 
          child: listItemContainer(child: Icon(Icons.remove, size: 30, color: const Color.fromARGB(255, 255, 0, 0)))),

          SizedBox(width: 10),

          GestureDetector(
            onTap: () {

              setState(() {
                SaveManager().addAbreviationToSavedList(Abreviation(abreviation: "", word: ""));
              });
            }, 
          child: listItemContainer(child: Icon(Icons.add, size: 30, color: Colors.green))),
        
      ])
    );
  }

  abreviationTextField(int index) {
    return Expanded(child: TextFormField(
      decoration: InputDecoration(
        labelText: "Abréviation",
      ),
      initialValue: abreviationsList[index].abreviation,
      onChanged: (value) {
        // Add logic to handle the submitted abbreviation
        setState(() {
          abreviationsList[index].abreviation = value;
        });
      },
    ));
  }

  wordTextField(int index) {
    return Expanded(child: TextFormField(
      decoration: InputDecoration(
        labelText: "Correspondance",
      ),
      initialValue: abreviationsList[index].word,
      onChanged: (value) {
        // Add logic to handle the submitted abbreviation
        setState(() {
          abreviationsList[index].word = value;
        });
      },
    ));
  }


  Widget searchBar() {
    return Expanded(
      child: mainContainer(
        padding: const EdgeInsets.only(left: 8, top: 11, bottom: 4.5, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: _searchBarControler,
                focusNode: _searchForcus,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _searchBarControler.clear();
                        FocusScope.of(context).unfocus();
                        searchString = "";
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                  border: InputBorder.none, // Removes the underline
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
              ),
            ),
          ],
        )
      )
    );
  }

}