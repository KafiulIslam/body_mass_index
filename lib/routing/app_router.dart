// import 'dart:js';
import 'package:body_mass_index/screens/input_page.dart';
import 'package:body_mass_index/screens/result_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  static final GoRouter router = GoRouter(
    // debugLogDiagnostics: true,
    routes: [
      GoRoute(
        // name: InputScreen.name,
        path: '/',
        builder: (context, state) =>   const InputScreen(),
      ),

      GoRoute(
        // name: LoginScreen.name,
        path: '/${ResultScreen.name}',
        builder: (context, state) => const ResultScreen(),
      ),

    ],
  );


}
