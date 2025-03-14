import 'package:go_router/go_router.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/logging_page.dart';
import 'package:my_fit_buddy/views/pages/authentification_pages/register_page.dart';
import 'package:my_fit_buddy/views/pages/exercises_list_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/home_page.dart';
import 'package:my_fit_buddy/views/pages/live_session_pages/main_live_session_page.dart';
import 'package:my_fit_buddy/views/pages/loading_pages/loading_page.dart';
import 'package:my_fit_buddy/views/pages/records_pages/exercise_sets_detail_page.dart';
import 'package:my_fit_buddy/views/pages/records_pages/records_detail_page.dart';
import 'package:my_fit_buddy/views/pages/session_pages/session_detail_page.dart';

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
      },
    ),
    GoRoute(
      name: 'exercises',
      path: '/exercises/:idSession',
      builder: (context, state) {
        final int id = int.parse(state.pathParameters['idSession']!);
        return ExercisesListPage(idSession: id);
      },
    ),
    GoRoute(
      name: 'liveSession',
      path: '/liveSession/:sessionId',
      builder: (context, state) {
        final sessionId = state.pathParameters['sessionId']!;
        return MainLiveSessionPage(sessionId: sessionId);
      },
    ),
    GoRoute(
      name: 'recordDetails',
      path: '/recordDetails/:recordId',
      builder: (context, state) {
        final recordId = int.parse(state.pathParameters['recordId']!);
        return RecordsDetailPage(recordId: recordId);
      },
    ),
    GoRoute(
      name: 'exerciseSetsDetail',
      path: '/exerciseSetsDetail/:exerciseId',
      builder: (context, state) {
        final int exerciseId = int.parse(state.pathParameters['exerciseId']!);
        return ExerciseSetsDetailPage(exerciseId: exerciseId);
      },
    ),
  ],
);
