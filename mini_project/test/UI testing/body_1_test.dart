import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mini_project/Views/Body_screen/body_1.dart';

Widget body1() => const MaterialApp(
      home: Scaffold(
        body: Body1(),
      ),
    );

void main() {
  group('Body 1 Test :', () {
    testWidgets('Text', (tester) async {
      await tester.pumpWidget(body1());
      await tester.pumpAndSettle();
      expect(find.text('Ayo Pesan Sekarang !!!'), findsWidgets);
      expect(find.text('Rp. 600 per Potong'), findsWidgets);
      expect(find.text('Rp. 400 per Potong'), findsWidgets);
      expect(find.text('Jika Disetrika Ditambah 10%'), findsWidgets);
    });

    testWidgets('Image', (tester) async {
      await tester.pumpWidget(body1());
      await tester.pumpAndSettle();
      expect(
          find.image(const AssetImage('assets/image/baju.png')), findsWidgets);
      expect(find.image(const AssetImage('assets/image/celana.png')),
          findsWidgets);
      expect(
          find.image(const AssetImage('assets/image/iron.png')), findsWidgets);
    });

    testWidgets('Map', (tester) async {
      await tester.pumpWidget(body1());
      await tester.pumpAndSettle();
      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets('Button', (tester) async {
      await tester.pumpWidget(body1());
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Widget', (tester) async {
      await tester.pumpWidget(body1());
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Positioned), findsWidgets);
    });
  });
}
