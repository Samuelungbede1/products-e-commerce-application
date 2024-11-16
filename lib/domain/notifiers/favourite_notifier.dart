import 'package:e_commerce/data/model/product.dart';
import 'package:e_commerce/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier(ref); 
});

class FavoritesNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  FavoritesNotifier(this.ref) : super([]);

  void toggleFavorite(Product product) {
    final currentUser = ref.read(authProvider.notifier).currentUser;

    if (state.contains(product)) {
      currentUser?.favourites.remove(product);
      state = state.where((item) => item.id != product.id).toList();
    } else {
      currentUser?.favourites.add(product);
      state = [...state, product];
    }
  }
}
