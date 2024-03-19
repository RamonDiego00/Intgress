class Category {
  final String uid;
  final String category;

  Category({required this.uid, required this.category});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(uid: map['uid'], category: map['category']);
  }

  Map<String, dynamic> toMap() {
    return {
      if (uid != null) 'uid': uid,
      'category': category,
    };
  }
}
