// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailRepositoryHash() => r'217dadde1efd820cdc5d8b441ae8ed9da10ee1cb';

/// See also [emailRepository].
@ProviderFor(emailRepository)
final emailRepositoryProvider = Provider<EmailRepository>.internal(
  emailRepository,
  name: r'emailRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmailRepositoryRef = ProviderRef<EmailRepository>;
String _$fetchEmailsHash() => r'e26be351bdb932dc67a9e6115859ee49baf19b5a';

/// See also [fetchEmails].
@ProviderFor(fetchEmails)
final fetchEmailsProvider = AutoDisposeFutureProvider<List<Email>>.internal(
  fetchEmails,
  name: r'fetchEmailsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchEmailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchEmailsRef = AutoDisposeFutureProviderRef<List<Email>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
