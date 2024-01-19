import 'package:email_alarm/models/email_model.dart';
import 'package:email_alarm/providers/auth_service_provider.dart';
import 'package:email_alarm/providers/config_provider.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/gmail/v1.dart';

class EmailRepository {
  EmailRepository(this.ref);
  final Ref ref;
  Future<List<Email>> fetchEmails() async {
    final emails = await _fetchMessages();
    if (emails == null) {
      return [];
    }
    return emails.map((e) {
      final subject = e.payload?.headers
          ?.firstWhere((element) => element.name == 'Subject')
          .value;
      final sender = e.payload?.headers
          ?.firstWhere((element) => element.name == 'From')
          .value;

      final content = e.snippet;
      final date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(e.internalDate ?? '0') * 1000,
      );
      return Email(
        subject: subject,
        sender: sender,
        content: content,
        date: date,
      );
    }).toList();
  }

  Future<List<Message>?> _fetchMessages() async {
    final config = await ref.read(configProvider.future);
    final after = (DateTime.now().millisecondsSinceEpoch / 1000).floor() -
        (60 * config.intervalInMinutes);
    //取得条件
    final specificSender = '{${config.specificSenders}}';

    final googleSignIn = ref.read(authServiceProvider).googleSignIn;
    final httpClient = await googleSignIn.authenticatedClient();
    assert(httpClient != null, 'Authenticated client missing!');
    final gmailApi = GmailApi(httpClient!);
    final reponse = await gmailApi.users.messages
        .list('me', q: '(is:unread after:$after from:$specificSender)');
    final messageList = reponse.messages;
    if (messageList == null) {
      return null;
    }
    final messages = await Future.wait<Message>(
      messageList.map((e) async {
        final message =
            await gmailApi.users.messages.get('me', e.id!, format: 'full');
        return message;
      }),
    );

    return messages;
  }
}
