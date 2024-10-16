import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/logging_page.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/register_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/home_page.dart';
import 'package:my_fit_buddy/views/pages/session_detail_page.dart';
import 'package:my_fit_buddy/views/pages/loading_pages/loading_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/loading',
  routes: [
    GoRoute(
      name: 'loading',
      path: '/loading',
      builder: (context, state) => const LoadingPage(),
    ),
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
      path: '/session/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return SessionDetailPage(id: id!); 
      }
    ),
  ],
);
