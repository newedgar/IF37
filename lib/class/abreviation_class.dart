///Often used sentences class
class Abreviation {
  Abreviation({
    required this.abreviation,
    required this.word
  }): id = DateTime.now().millisecondsSinceEpoch;

  String abreviation;
  String word;
  int id;


  factory Abreviation.fromJson(Map<String, dynamic> json) {
    return Abreviation(
      abreviation: json['Abreviation'] as String,
      word: json['Word'] as String,
    )..id = json['id'] as int;
  }

  Map<String, dynamic> toJson() {
    return {
      'Abreviation': abreviation,
      'Word': word,
      'id': id,
    };
  }
}