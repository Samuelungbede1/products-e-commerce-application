import 'package:e_commerce/core/constant/api_constant.dart';
import 'package:e_commerce/data/model/user.dart';
import 'package:e_commerce/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(AuthRepository());
});

class AuthStateNotifier extends StateNotifier<bool> {
  final AuthRepository _authRepository;


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User? _user;  

  AuthStateNotifier(this._authRepository) : super(false) {
    _initialize();
  }

  void _initialize() async {
    state = await _authRepository.isLoggedIn();
    if (state) {
      _user = await getLoggedInUser(); 
    }
  }

  User? get currentUser => _user;





 @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String?> validateAndRegister() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty) {
      return 'Name cannot be empty.';
    }
    if (email.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email address.';
    }
    if (password.isEmpty || password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    try {
      final user = User(name: name, email: email, password: password);
      await _authRepository.register(user);
       passwordController.clear();
      state = true;
      return null; 
    } catch (e) {
      return 'Failed to register: ${e.toString()}';
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }






 Future<String?> validateAndLogin() async {
   
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email address.';
    }
    if (password.isEmpty || password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }


    try {
      await login(email, password);
      return null;
    } catch (e) {
      return 'Failed to login: ${e.toString()}';
    }
  }

  Future<void> login(String email, String password) async {
    await _authRepository.login(email, password);
    final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.authTokenKey, 'access_token');
    state = true;
    _user = await getLoggedInUser();
  }
 

  Future<void> register(User user) async {
    await _authRepository.register(user);
    state = true;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = false;
    _user = null; 
  }


  Future<User?> getLoggedInUser() async {
    return await _authRepository.getLoggedInUser(); 
  }
}
