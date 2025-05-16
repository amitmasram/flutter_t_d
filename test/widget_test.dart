// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cv_d_project/features/data/models/users_model.dart';
import 'package:cv_d_project/features/data/repositories/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cv_d_project/main.dart';
import 'package:hive/hive.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
 final userBox = await Hive.openBox<UsersModel>('users');
    final apiService = ApiService(Dio(BaseOptions(contentType: 'application/json')));
    // Build our app and trigger a frame.
    await tester.pumpWidget( ClearViewApp(userBox: userBox, apiService: apiService));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
