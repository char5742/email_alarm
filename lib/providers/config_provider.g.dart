// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configRepositoryHash() => r'a218eb44333425b62ba7ced1b63a68347552f522';

/// See also [configRepository].
@ProviderFor(configRepository)
final configRepositoryProvider = Provider<ConfigRepository>.internal(
  configRepository,
  name: r'configRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigRepositoryRef = ProviderRef<ConfigRepository>;
String _$configServiceHash() => r'975d977666d069dee9b060937bb3531523d54dce';

/// See also [configService].
@ProviderFor(configService)
final configServiceProvider = Provider<ConfigService>.internal(
  configService,
  name: r'configServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigServiceRef = ProviderRef<ConfigService>;
String _$configHash() => r'919bb715d7ef09095d667970bcf6c2b79c7dc310';

/// See also [config].
@ProviderFor(config)
final configProvider = FutureProvider<Config>.internal(
  config,
  name: r'configProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$configHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigRef = FutureProviderRef<Config>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
