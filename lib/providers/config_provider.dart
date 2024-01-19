import 'package:email_alarm/models/config_model.dart';
import 'package:email_alarm/repositories/config_repository.dart';
import 'package:email_alarm/services/config_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_provider.g.dart';

@Riverpod(keepAlive: true)
ConfigRepository configRepository(ConfigRepositoryRef _) => ConfigRepository();

@Riverpod(keepAlive: true)
ConfigService configService(ConfigServiceRef ref) => ConfigService(ref);

@Riverpod(keepAlive: true)
Future<Config> config(ConfigRef ref) async {
  return ref.read(configServiceProvider).getConfig();
}
