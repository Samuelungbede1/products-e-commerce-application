import 'package:e_commerce/core/constant/api_constant.dart';
import 'package:e_commerce/data/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  final ApiService _apiService = ApiService();

  AuthNotifier() : super(false);

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.authTokenKey, response.data['access_token']);
      state = true;
    } catch (e) {
      state = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.authTokenKey);
    state = false;
  }
  
}
