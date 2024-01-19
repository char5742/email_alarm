import 'package:email_alarm/pages/playing_page.dart';
import 'package:email_alarm/pages/signin_page.dart';
import 'package:email_alarm/providers/alarm_service_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'pages/about_page.dart';
import 'pages/home_page.dart';
import 'pages/request_permission_page.dart';
import 'pages/settings_page.dart';
import 'providers/auth_service_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) async {
          if (!ref.watch(
            isLoggedInProvider.select(
              (value) => value.value ?? true,
            ),
          )) {
            return '/signin';
          }
          if (state.path == '/signin') {
            return '/';
          }
          if (ref.watch(
            isPlayingProvider.select((value) => value.value ?? false),
          )) {
            return '/playing';
          }
          return null;
        },
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'about',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: 'requestPermission',
            builder: (context, state) => const RequestPermissionPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: '/playing',
        builder: (context, state) => const PlayingPage(),
      ),
    ],
  );
}
