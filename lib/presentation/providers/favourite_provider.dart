import 'package:e_commerce/data/model/product.dart';
import 'package:e_commerce/domain/notifiers/favourite_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier(ref);
});


