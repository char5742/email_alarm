import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

/// Notigication permission request page
class RequestPermissionPage extends StatelessWidget {
  const RequestPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please allow the following permissions.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Notification',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: theme.textTheme.bodyLarge,
              ),
              onPressed: () async {
                await openAppSettings();
                if (context.mounted) {
                  context.go('/');
                }
              },
              child: const Text('Open App Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
