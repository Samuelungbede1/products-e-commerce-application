import 'dart:convert';
import 'package:e_commerce/core/constant/api_constant.dart';
import 'package:e_commerce/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _usersKey = 'users';
  static const _loggedInUserKey = 'logged_in_user';

  Future<void> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getAllUsers();

    if (users.any((existingUser) => existingUser.email == user.email)) {
      throw Exception("User with this email already exists.");
    }

    users.add(user);
    await prefs.setString(_usersKey, json.encode(users.map((u) => u.toJson()).toList()));
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getAllUsers();

    final user = users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception("Invalid email or password."),
    );

    await prefs.setString(_loggedInUserKey, json.encode(user.toJson()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.authTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_loggedInUserKey);
  }

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_loggedInUserKey);
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  Future<List<User>> _getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      final List<dynamic> usersList = json.decode(usersJson);
      return usersList.map((userJson) => User.fromJson(userJson)).toList();
    }
    return [];
  }
}
