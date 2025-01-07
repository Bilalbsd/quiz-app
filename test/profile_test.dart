import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp1_flutter_bilalb/display/profile_display.dart';

void main() {
  testWidgets('ProfileHomePage has a title and avatar',
      (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileHomePage(),
      ),
    );

    // Vérifier que le titre 'Profile Home Page' est présent
    expect(find.text('Profile Home Page'), findsOneWidget);

    // Vérifier que l'avatar est bien visible
    // expect(find.byType(AssetImage), findsOneWidget);

    // Vérifier que le bouton "Commencer le Quiz" est présent
    expect(find.text('Commencer le Quiz'), findsOneWidget);
  });

  testWidgets('ProfileHomePage contains the profile information',
      (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileHomePage(),
      ),
    );

    // Vérifier que le nom "Bilal" est affiché
    expect(find.text('Bilal'), findsOneWidget);

    // Vérifier que l'email "bilal@etu.umontpellier.fr" est affiché
    expect(find.text('bilal@etu.umontpellier.fr'), findsOneWidget);

    // Vérifier que le réseau social est affiché
    expect(find.text('Réseau social : @BilalBsd'), findsOneWidget);
  });

  testWidgets('ProfileHomePage navigates to /quiz on button press',
      (WidgetTester tester) async {
    // Créer une clé GlobalKey pour le Navigator
    final navigatorKey = GlobalKey<NavigatorState>();

    // Construire la page avec un MaterialApp pour tester la navigation
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: const ProfileHomePage(),
        routes: {
          '/quiz': (context) => const Scaffold(body: Text('Quiz Page')),
        },
      ),
    );

    // Trouver le bouton "Commencer le Quiz"
    final quizButton = find.text('Commencer le Quiz');

    // Vérifier que le bouton est affiché
    expect(quizButton, findsOneWidget);

    // Appuyer sur le bouton pour déclencher la navigation
    await tester.tap(quizButton);

    // Faire pomper pour voir l'animation de navigation
    await tester.pumpAndSettle();

    // Vérifier que la navigation a eu lieu
    expect(find.text('Quiz Page'), findsOneWidget);
  });
}
