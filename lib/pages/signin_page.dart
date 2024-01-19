import 'package:email_alarm/providers/auth_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SigninPage extends HookConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        () async {
          while (true) {
            await ref.read(authServiceProvider).signIn();
          }
        }();
        return null;
      },
      const [],
    );
    return const Scaffold();
  }
}
