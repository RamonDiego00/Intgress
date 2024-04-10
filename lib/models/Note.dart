class Note {
  final String id;
  final String user_id;
  final String category;
  final String title;
  final String message;

  Note({
    required this.id,
    required this.user_id,
    required this.category,
    required this.title,
    required this.message,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        user_id: map['user_id'],
        category: map['category'],
        title: map['title'],
        message: map['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'category': category,
      'title': title,
      'message': message,
    };
  }
}
