import 'package:e_commerce/presentation/screens/login_screen.dart';
import 'package:e_commerce/presentation/screens/product_detail_screen.dart';
import 'package:e_commerce/presentation/screens/product_listing_screen.dart';
import 'package:e_commerce/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
        case '/products':
        return MaterialPageRoute(builder: (_) => const ProductListingScreen());
        case '/details':
        return MaterialPageRoute(builder: (_) => const ProductDetailScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
//details