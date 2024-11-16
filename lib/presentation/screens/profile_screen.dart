import 'package:e_commerce/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final currentUser = authNotifier.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: IconButton(
                      icon: const Icon(
                        color: Colors.grey,
                        Icons.account_circle,
                        size: 130,
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
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      currentUser.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      currentUser.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (currentUser.favourites.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Favorites:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: currentUser.favourites.length,
                            itemBuilder: (context, index) {
                              final product = currentUser.favourites[index];
                              final screenWidth =
                                  MediaQuery.of(context).size.width;
                              final cardWidth = screenWidth *
                                  0.4;

                              return Container(
                                width: cardWidth,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        product.image ?? '',
                                        width: double.infinity,
                                        height: cardWidth *
                                            0.6,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      product.title ?? '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You have no favorites yet.',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(
                            Icons.favorite_outline_sharp,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await authNotifier.logout();
          Navigator.pushReplacementNamed(context, '/login');
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.logout_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
