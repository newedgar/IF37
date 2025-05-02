///Often used sentences class
class Sentence {
  Sentence({
    required this.sentence,
  }): id = DateTime.now().millisecondsSinceEpoch;

  String sentence;
  int id;


  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
      sentence: json['Sentence'] as String,
    )..id = json['id'] as int;
  }

  Map<String, dynamic> toJson() {
    return {
      'Sentence': sentence,
      'id': id,
    };
  }
}