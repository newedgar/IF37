import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AbbreviationFilterPage(),
    );
  }
}

class AbbreviationFilterPage extends StatefulWidget {
  @override
  _AbbreviationFilterPageState createState() => _AbbreviationFilterPageState();
}

class _AbbreviationFilterPageState extends State<AbbreviationFilterPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> allAbbreviations = [
    'HTML', 'CSS', 'JS', 'TS', 'PHP', 'SQL', 'C++', 'C#', 'JAVA', 'KOTLIN', 'DART'
  ];
  List<String> filteredAbbreviations = [];

  @override
  void initState() {
    super.initState();
    filteredAbbreviations = List.from(allAbbreviations);

    _searchController.addListener(() {
      String input = _searchController.text.toUpperCase();
      setState(() {
        filteredAbbreviations = allAbbreviations
            .where((abbr) => abbr.startsWith(input))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget buildButton(String abbr) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          print("Pressed: $abbr");
        },
        child: Text(abbr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recherche Abréviations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildButton("+"),
            // Barre de recherche
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            // Liste filtrée des boutons
            Expanded(
              child: ListView(
                children:
                    filteredAbbreviations.map(buildButton).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

   

  




