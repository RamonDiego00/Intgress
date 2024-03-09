import 'Lesson.dart';

class Note {
  final int? id;
  final String category;
  final String title;
  final String message;
  final List<Lesson> lessons;

  Note({
    this.id,
    required this.category,
    required this.title,
    required this.message,
    required this.lessons
  });

  // Construtor para converter um Map para uma Note
  factory Note.fromMap(Map<String, dynamic> map) {
    List<Lesson> lessons = (map['lessons'] != null) ? List<Lesson>.from(map['lessons']) : [];
    return Note(
        id: map['id'],
        category: map['category'],
        title: map['title'],
        message: map['message'],
        lessons: lessons);
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'category': category,
      'title': title,
      'message': message,
    };
  }
}
