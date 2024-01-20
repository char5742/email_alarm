import 'package:email_alarm/providers/email_alarm_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayingPage extends HookConsumerWidget {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: theme.textTheme.displaySmall,
          ),
          onPressed: () {
            ref.read(emailAlarmServiceProvider).stopMonitaring();
          },
          child: const Padding(
            padding: EdgeInsets.all(32),
            child: Text('Stop'),
          ),
        ),
      ),
    );
  }
}
