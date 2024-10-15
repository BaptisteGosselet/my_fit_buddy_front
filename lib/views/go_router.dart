import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/logging_page.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/register_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/home_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/session_detail_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/register',
  routes: [
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: 'logging',
      path: '/logging',
      builder: (context, state) => const LoggingPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'sessionDetails',
      path: '/session',
      builder: (context, state) => const SessionDetailPage(),
    ),
  ],
);
