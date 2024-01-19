import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_model.freezed.dart';

@freezed
class Email with _$Email {
  const factory Email({
    String? sender,
    String? subject,
    String? content,
    DateTime? date,
  }) = _Email;
}
