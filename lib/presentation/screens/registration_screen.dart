import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: authNotifier.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: authNotifier.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: authNotifier.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final error = await authNotifier.validateAndRegister();
                if (error != null) {
                
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(error),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
        
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Registration successful!....'),
                    ),
                  );

                  await Future.delayed(const Duration(seconds: 3));
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
