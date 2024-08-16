import 'package:final_assignment/features/booking/presentation/view/booking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const artistId = 'artist123';

  testWidgets('renders BookingView', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: BookingView(artistId),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the BookingView is rendered
    expect(find.byType(BookingView), findsOneWidget);
  });

  testWidgets('displays all text fields and date/time pickers', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: BookingView(artistId),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that all the text fields are displayed
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Preferred Date'), findsOneWidget);
    expect(find.text('Preferred Time'), findsOneWidget);
  });

  testWidgets('adds booking successfully', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: BookingView(artistId),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
  
}
