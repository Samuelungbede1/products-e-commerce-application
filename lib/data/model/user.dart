import 'package:e_commerce/data/model/product.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String? image;
  final List<Product> favourites;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.image,
    this.favourites = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'favourites': favourites.map((product) => product.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      favourites: (json['favourites'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item))
              .toList() ??
          [],
    );
  }
}
