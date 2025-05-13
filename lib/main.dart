import 'package:cv_d_project/features/presentation/pages/splash_page.dart';
import 'package:cv_d_project/features/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CLEARVIEW',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),

      routerConfig: _router,
    );
  }
}

GoRouter _router = GoRouter(
  initialLocation: '/splash',
  errorBuilder: (context, state) {
    return const Scaffold(body: Center(child: Text('Error')));
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/splash",
      name: "name",
      builder: (context, state) {
        return SplashPage();
      },
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) {
        return const UserListPage();
      },
    ),
  ],
);
