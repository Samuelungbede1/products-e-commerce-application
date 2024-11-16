import 'package:flutter/material.dart';
import 'package:e_commerce/data/model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product?.title ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Image.network(product?.image ?? ''),
              const SizedBox(height: 16),

              Text(
                product?.title ?? '',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Text(
                '\$${product?.price}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),

              Text(product?.description ?? ''),
              const SizedBox(height: 16),

              if (product?.rating != null)
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (product?.rating?.rate ?? 0).floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${product?.rating?.rate?.toStringAsFixed(1)} / 5)',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${product?.rating?.count} reviews',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
