import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/logging_page.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/register_page.dart';

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
  ],
);
