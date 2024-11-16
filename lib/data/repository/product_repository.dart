
import 'package:dio/dio.dart';
import 'package:e_commerce/data/model/product.dart';

class ProductRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  Future<List<Product>> fetchProducts() async {
    final response = await _dio.get('/products');
    return (response.data as List).map((json) => Product.fromJson(json)).toList();
  }
}
