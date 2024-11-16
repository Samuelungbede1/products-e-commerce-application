import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/data/model/product.dart';
import 'package:e_commerce/data/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  final ApiService _apiService = ApiService();

  Future<void> fetchProducts() async {
    try {
      final response = await _apiService.get('/products');
      final List<Product> products = (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
      state = products;
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionTimeout) {
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
      } else if (dioError.type == DioExceptionType.badResponse) {
      } else if (dioError.type == DioExceptionType.cancel) {
      } else if (dioError.type == DioExceptionType.unknown) {
        if (dioError.error is SocketException) {
        } else {}
      }
    }
  }
}
