import 'package:go_router/go_router.dart';

import '../../features/auth/view/pages/about_me_page.dart';
import '../../features/auth/view/pages/login_page.dart';
import '../../features/auth/view/pages/signup_page.dart';

class RouteService {
  static final routerConfig = GoRouter(initialLocation: '/signup', routes: [
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/about-me',
      builder: (context, state) => const AboutMePage(),
    ),
  ]);
}
