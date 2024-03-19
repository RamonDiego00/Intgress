

class Note {
  final String? id;
  final String idUser;
  final String category;
  final String title;
  final String message;

  Note({
    this.id,
    required this.idUser,
    required this.category,
    required this.title,
    required this.message,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        idUser: map['idUser'],
        category: map['category'],
        title: map['title'],
        message: map['message']);
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
