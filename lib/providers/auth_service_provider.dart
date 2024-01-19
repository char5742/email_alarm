import 'package:email_alarm/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef _) {
  return AuthService();
}

@Riverpod(keepAlive: true)
Stream<bool> isLoggedIn(IsLoggedInRef ref) async* {
  yield ref.watch(authServiceProvider).isLoggedIn;
  yield* ref.watch(authServiceProvider).loggedInStateChanges;
}
