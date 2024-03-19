class User {
  final String? id;
  final String name;
  final String email;
  final String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], email: map['email'],password: map['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
