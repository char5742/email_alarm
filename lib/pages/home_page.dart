import 'package:email_alarm/providers/email_alarm_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMonitaring = ref.watch(isMonitaringProvider);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: isMonitaring.when(
          data: (isMonitaring) {
            if (isMonitaring) {
              return const _StopMonitaringButton();
            } else {
              return const _StartMonitaringButton();
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
      ),
    );
  }
}

class _StartMonitaringButton extends HookConsumerWidget {
  const _StartMonitaringButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: theme.textTheme.displaySmall,
      ),
      onPressed: () {
        ref.read(emailAlarmServiceProvider).startMonitaring();
      },
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Text('Start waiting'),
      ),
    );
  }
}

class _StopMonitaringButton extends HookConsumerWidget {
  const _StopMonitaringButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: theme.textTheme.displaySmall,
      ),
      onPressed: () {
        ref.read(emailAlarmServiceProvider).stopMonitaring();
      },
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Text('Stop waiting'),
      ),
    );
  }
}
