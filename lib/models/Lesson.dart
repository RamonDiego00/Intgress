class Lesson {
  final int? id;
  final int? note_id;
  final String statement;
  final String question;
  final String alternative1;
  final String alternative2;
  final String alternative3;
  final String correct;

  Lesson({
    this.id,
    this.note_id,
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
      note_id: map['id'],
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
      if (id != null) 'id': id,
      if (note_id != null) 'id': note_id,
      'statement': statement,
      'question': question,
      'alternative1': alternative1,
      'alternative2': alternative2,
      'alternative3': alternative3,
      'correct': correct,
    };
  }
}
