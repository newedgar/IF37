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
  TextEditingController _inputController = TextEditingController();
  TextEditingController _newAbbrController = TextEditingController();
  TextEditingController _newContentController = TextEditingController();
  TextEditingController _deleteController = TextEditingController();

  List<String> allAbbreviations = [
    'HTML', 'CSS', 'JS', 'TS', 'PHP', 'SQL', 'C++', 'C#', 'JAVA', 'KOTLIN', 'DART'
  ];
  Map<String, String> contentByAbbr = {}; // Pour stocker les contenus associés
  List<String> filteredAbbreviations = [];

  String? selectedAbbreviation;
  String? userInput;

  // Étapes d'ajout
  bool isAdding = false;
  bool waitingForContent = false;
  String? newAbbr;

  // Suppression
  bool isDeleting = false;

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
    _inputController.dispose();
    _newAbbrController.dispose();
    _newContentController.dispose();
    _deleteController.dispose();
    super.dispose();
  }

  Widget buildButton(String abbr) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedAbbreviation = abbr;
            _inputController.text = contentByAbbr[abbr] ?? 'Texte par défaut pour $abbr';
            userInput = null;
          });
        },
        child: Text(abbr),
      ),
    );
  }

  Widget buildInputArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Saisir un texte pour "$selectedAbbreviation"', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _inputController,
          decoration: InputDecoration(
            hintText: 'Entrez un texte...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            setState(() {
              userInput = _inputController.text;
              contentByAbbr[selectedAbbreviation!] = userInput!;
            });
            print('Texte saisi pour $selectedAbbreviation: $userInput');
          },
          child: Text('Valider'),
        ),
      ],
    );
  }

  Widget buildAddAbbreviationUI() {
    if (!isAdding) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!waitingForContent) ...[
          Text('Nouvelle abréviation :'),
          TextField(
            controller: _newAbbrController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: 8),
          Row(
  children: [
    ElevatedButton(
      onPressed: () {
        setState(() {
          newAbbr = _newAbbrController.text.trim().toUpperCase();
          if (newAbbr != '' && !allAbbreviations.contains(newAbbr)) {
            waitingForContent = true;
          }
        });
      },
      child: Text('Valider'),
    ),
    SizedBox(width: 10),
    TextButton(
      onPressed: () {
        setState(() {
          isAdding = false;
          waitingForContent = false;
          _newAbbrController.clear();
        });
      },
      child: Text('Annuler'),
    ),
  ],
),
        ] else ...[
          Text('Contenu associé à "$newAbbr" :'),
          TextField(
            controller: _newContentController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                allAbbreviations.add(newAbbr!);
                contentByAbbr[newAbbr!] = _newContentController.text;
                filteredAbbreviations = List.from(allAbbreviations);
                isAdding = false;
                waitingForContent = false;
                _newAbbrController.clear();
                _newContentController.clear();
              });
            },
            child: Text('Ajouter l’abréviation'),
          ),
        ]
      ],
    );
  }

  Widget buildDeleteAbbreviationUI() {
    if (!isDeleting) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Abréviation à supprimer :'),
        TextField(
          controller: _deleteController,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: 8),
        Row(
  children: [
    ElevatedButton(
      onPressed: () {
        setState(() {
          String toDelete = _deleteController.text.trim().toUpperCase();
          allAbbreviations.remove(toDelete);
          filteredAbbreviations = List.from(allAbbreviations);
          contentByAbbr.remove(toDelete);
          _deleteController.clear();
          isDeleting = false;
        });
      },
      child: Text('Supprimer'),
    ),
    SizedBox(width: 10),
    TextButton(
      onPressed: () {
        setState(() {
          isDeleting = false;
          _deleteController.clear();
        });
      },
      child: Text('Annuler'),
    ),
  ],
)
,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Abréviations'),
     
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       child: Column(
  children: [
    // Ligne avec les deux boutons
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          tooltip: 'Supprimer une abréviation',
          onPressed: () {
            setState(() {
              isDeleting = true;
              _deleteController.clear();
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          tooltip: 'Ajouter une abréviation',
          onPressed: () {
            setState(() {
              isAdding = true;
              waitingForContent = false;
              _newAbbrController.clear();
              _newContentController.clear();
            });
          },
        ),
      ],
    ),

    
  

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

            buildAddAbbreviationUI(),
            buildDeleteAbbreviationUI(),

            Expanded(
              child: ListView(
                children: [
                  ...filteredAbbreviations.map(buildButton),
                  if (selectedAbbreviation != null) ...[
                    SizedBox(height: 20),
                    buildInputArea(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
