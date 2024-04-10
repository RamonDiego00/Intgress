class Lesson {
  final String id;
  final String note_id;

  final String category_note;
  final String title_note;

  final String statement;
  final String question;
  final String alternative1;
  final String alternative2;
  final String alternative3;
  final String correct;

  Lesson({
    required this.id,
    required this.note_id,
    required this.category_note,
    required this.title_note,
    required this.statement,
    required this.question,
    required this.alternative1,
    required this.alternative2,
    required this.alternative3,
    required this.correct,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      note_id: map['note_id'],
      category_note: map['category_note'],
      title_note: map['title_note'],
      statement: map['statement'],
      question: map['question'],
      alternative1: map['alternative1'],
      alternative2: map['alternative2'],
      alternative3: map['alternative3'],
      correct: map['correct'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note_id': note_id,
      'category_note': category_note,
      'title_note': title_note,
      'statement': statement,
      'question': question,
      'alternative1': alternative1,
      'alternative2': alternative2,
      'alternative3': alternative3,
      'correct': correct,
    };
  }
}
