import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/Views/Body_screen/Consumer/Body2_screen/body_2_empty.dart';

Widget empty() => const MaterialApp(
      home: Scaffold(
        body: Body2EmptyScreen(),
      ),
    );

void main() {
  group('Body 2 Test :', () {
    testWidgets('Text', (tester) async {
      await tester.pumpWidget(empty());
      await tester.pumpAndSettle();
      expect(find.text('Belum Ada Pesanan'), findsWidgets);
    });

    testWidgets('Image', (tester) async {
      await tester.pumpWidget(empty());
      await tester.pumpAndSettle();
      expect(
          find.image(const AssetImage('assets/image/cloud.png')), findsWidgets);
    });

    testWidgets('Widget', (tester) async {
      await tester.pumpWidget(empty());
      await tester.pumpAndSettle();
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
