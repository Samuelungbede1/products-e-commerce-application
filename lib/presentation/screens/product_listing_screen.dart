import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/presentation/providers/favourite_provider.dart';
import 'package:e_commerce/presentation/providers/grouped_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce/presentation/screens/product_detail_screen.dart';
import 'package:e_commerce/presentation/screens/profile_screen.dart'; // Import the ProfileScreen
import 'package:shimmer/shimmer.dart';

class ProductListingScreen extends ConsumerWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedProductsAsync = ref.watch(groupedProductsProvider);

    return Scaffold(
      body: groupedProductsAsync.when(
        data: (groupedProducts) {
          final categories = groupedProducts.keys.toList();

          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Products'),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: categories.map((category) {
                    return Tab(
                      child: Text(
                        category,
                        softWrap: false,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: categories.map((category) {
                  final categoryProducts = groupedProducts[category]!;

                  return ListView.builder(
                    itemCount: categoryProducts.length,
                    itemBuilder: (context, index) {
                      final product = categoryProducts[index];
                      final isFavorite = ref.watch(
                        favoritesProvider
                            .select((favorites) => favorites.contains(product)),
                      );

                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: product.image ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                        title: Text(product.title ?? ''),
                        subtitle: Text('\$${product.price}'),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(product),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
        loading: () => Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  width: 50,
                  height: 50,
                ),
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  height: 16.0,
                  width: double.infinity,
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  height: 14.0,
                  width: 100,
                ),
              ),
            ),
          ),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'No Connectivity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Service is temporarily unavailable, try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(groupedProductsProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
