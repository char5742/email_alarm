import 'package:email_alarm/providers/auth_service_provider.dart';
import 'package:email_alarm/providers/config_provider.dart';
import 'package:email_alarm/utils/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailContainer(),
            SizedBox(height: 32),
            SpecificSendersField(),
            SizedBox(height: 128),
            SignOutButton(),
          ],
        ),
      ),
    );
  }
}

class EmailContainer extends HookConsumerWidget {
  const EmailContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authServiceProvider).currentUser?.email;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Email: $uid'),
        IconButton(
          onPressed: () async {
            if (uid == null) {
              return;
            }
            await copyToClipboard(uid);
          },
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}

class SpecificSendersField extends HookConsumerWidget {
  const SpecificSendersField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(configProvider);

    return configAsync.when(
      data: (config) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextFormField(
            initialValue: config.specificSenders,
            decoration: const InputDecoration(
              labelText: 'senders',
            ),
            onFieldSubmitted: (value) {
              ref
                  .read(configServiceProvider)
                  .setConfig(config.copyWith(specificSenders: value));
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}

class SignOutButton extends HookConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(authServiceProvider).signOut();
      },
      child: const Text('ログアウト'),
    );
  }
}
