import 'package:flutter/material.dart';

/// Flutter code sample for [SearchBar].

void main() => runApp(const SearchBarApp());

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}
class abreviationButton extends StatelessWidget{
  const abreviationButton({super.key,
  required this.abreviation,
  required this.meaning,
  });
  final String abreviation;
  final String? meaning;
   @override
  Widget build(BuildContext context){
    return  ElevatedButton(
                onPressed: () {
                  
                },
                child: Text(abreviation),
              );
  }
}
class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  String textSearchBar="";
  var abreviations={"bjr" : "bonjour","cc":"coucou","slt":"salut"};
  List<Widget> listAbreviationsDisplay=[];

  @override
  Widget build(BuildContext context) {
    
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
    
    if(textSearchBar.isNotEmpty){
      if(abreviations[textSearchBar]!=null){
        setState(() {
           listAbreviationsDisplay.add(abreviationButton(abreviation: textSearchBar, meaning: abreviations[textSearchBar]));
        });
       
      }else{
        var k =abreviations.keys;
        var I = k.iterator;
        while(I.moveNext()==true){
          setState(() {
             listAbreviationsDisplay.add(abreviationButton(abreviation: I.current, meaning: abreviations[I.current]));
          });
         

        }
      }
    }else{
        var k =abreviations.keys;
        var I = k.iterator;
        while(I.moveNext()==true){
          setState(() {
            listAbreviationsDisplay.add(abreviationButton(abreviation: I.current, meaning: abreviations[I.current]));
          });
          
        }
    }

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Chercher des abréviations')),
        body: 
        Column(children: [
         
          Padding(
          padding: const EdgeInsets.all(8.0),
          child : SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                  setState(() {
                    textSearchBar=controller.text;
                    
                  });
                  
                },
                onSubmitted:(value) {
                    textSearchBar=value;  
                }, 
                
                
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: "Changer le mode d'affichage",
                    child: IconButton(
                      isSelected: isDark,
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      },
                      icon: const Icon(Icons.wb_sunny_outlined),
                      selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  ),
                ],
              );
            },
            
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
          
        ),
        Row(children: listAbreviationsDisplay,),
        ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Next'),
              ),
        ],)
                
      ),
    );
  }
}


   

  




