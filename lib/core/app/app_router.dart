
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/model/user_model.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screen/main_screen.dart';
import '../common/error_page.dart';
import 'app_prefs.dart';



class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(path: '/', builder: (context, state) {
        final  user = state.extra as User?;
        return  MainScreen(user: user,);
      }),
      GoRoute(
          path: '/login',
          builder: (context, state) {
            return const LoginScreen();
          },
      ),
    ],

    redirect: (context, state) async {
      final appPreferences = GetIt.instance<AppPreferences>();
      final token = appPreferences.getCredential();

      final isLoggingIn = state.matchedLocation == '/login';

      if (token == null) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn) {
        return '/';
      }

      return null;
    },
    errorBuilder: (context, state) => ErrorPage(
      error: state.error!.message,
    ),
  );
}
