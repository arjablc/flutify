import 'package:flutify/features/auth/view/pages/login_page.dart';
import 'package:flutify/features/auth/view/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

class RouteService {
  static final routerConfig = GoRouter(initialLocation: '/signup', routes: [
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    )
  ]);
}
