import 'package:email_alarm/providers/auth_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SigninPage extends HookConsumerWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        () async {
          await ref.read(authServiceProvider).signIn();
        }();
        return null;
      },
      const [],
    );
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SignInButton(
              isLight ? Buttons.Google : Buttons.GoogleDark,
              onPressed: ref.read(authServiceProvider).signIn,
            ),
          ],
        ),
      ),
    );
  }
}
