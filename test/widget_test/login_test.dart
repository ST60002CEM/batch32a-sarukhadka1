import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';

void main() {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the LoginView is rendered
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('displays email and password text fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the email and password fields are displayed
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('displays login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the login button is displayed
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });
}
