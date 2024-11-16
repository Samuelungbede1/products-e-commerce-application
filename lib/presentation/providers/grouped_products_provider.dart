import 'package:collection/collection.dart';
import 'package:e_commerce/data/model/product.dart';
import 'package:e_commerce/presentation/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupedProductsProvider =
    FutureProvider<Map<String, List<Product>>>((ref) async {
  final products = await ref.watch(
      productProvider.future);
  return groupBy(products, (product) => product.category ?? 'Uncategorized');
});
