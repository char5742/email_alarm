import 'package:email_alarm/models/config_model.dart';
import 'package:email_alarm/providers/config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigService {
  ConfigService(this.ref);
  final Ref ref;

  Future<Config> getConfig() {
    return ref.read(configRepositoryProvider).getConfig();
  }

  Future<void> setConfig(Config config) async {
    await ref.read(configRepositoryProvider).setConfig(config);
    ref.invalidate(configProvider);
  }
}
