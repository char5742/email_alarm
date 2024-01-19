import 'package:email_alarm/models/email_model.dart';
import 'package:email_alarm/repositories/email_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_provider.g.dart';

@Riverpod(keepAlive: true)
EmailRepository emailRepository(EmailRepositoryRef ref) => EmailRepository(ref);

@riverpod
Future<List<Email>> fetchEmails(FetchEmailsRef ref) =>
    ref.watch(emailRepositoryProvider).fetchEmails();
