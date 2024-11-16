import 'package:e_commerce/core/constant/api_constant.dart';
import 'package:e_commerce/core/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(AppConstants.authTokenKey);
  runApp(ProviderScope(child: MyApp(isAuthenticated: token != null)));
}


class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isAuthenticated ? '/products' : '/login',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
