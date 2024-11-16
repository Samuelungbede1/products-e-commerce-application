
import 'package:e_commerce/data/model/product.dart';
import 'package:e_commerce/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  return ProductRepository().fetchProducts();
});
