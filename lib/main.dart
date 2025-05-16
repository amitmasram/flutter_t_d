import 'package:cv_d_project/features/data/models/users_model.dart';
import 'package:cv_d_project/features/data/repositories/api_service.dart';
import 'package:cv_d_project/features/presentation/bloc/users_bloc.dart';
import 'package:cv_d_project/features/presentation/bloc/users_event.dart';
import 'package:cv_d_project/features/presentation/pages/splash_page.dart';
import 'package:cv_d_project/features/presentation/pages/user_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UsersModelAdapter());

  // Open Hive box for storing users
  final userBox = await Hive.openBox<UsersModel>('users');

  // Run app with userBox passed down
  final apiService = ApiService(Dio(BaseOptions(contentType: 'application/json')));
  runApp(ClearViewApp(userBox: userBox, apiService: apiService));
}

class ClearViewApp extends StatelessWidget {
  final Box<UsersModel> userBox;
  final ApiService apiService;

  const ClearViewApp({
    super.key,
    required this.userBox,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(userBox, apiService)..add(LoadUsers()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CLEARVIEW',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        routerConfig: _router,
      ),
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
