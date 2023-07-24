class User {
  final int id;
  final String name;
  final String image;
  final String email;
  final String password;

  const User ({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        email: json['email'],
        password: json['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'email': email,
      'password': email
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, image: $image, email: $email, password: $password}';
  }
}