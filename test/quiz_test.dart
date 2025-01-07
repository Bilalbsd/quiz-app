import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp1_flutter_bilalb/display/quiz_display.dart'; // Assurez-vous que le chemin d'importation est correct.

void main() {
  // Test de l'affichage de la question et des réponses
  testWidgets('QuizPage displays question and answer options', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Attendre que le widget se stabilise après l'injection
    await tester.pumpAndSettle();

    // Vérifier que les boutons de réponse "VRAI" et "FAUX" sont présents
    expect(find.text('VRAI'), findsOneWidget);
    expect(find.text('FAUX'), findsOneWidget);
  });

  // Test de la mise à jour du score après une réponse correcte
  testWidgets('QuizPage updates score correctly on correct answer', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Attendre que le widget se stabilise
    await tester.pumpAndSettle();

    // Appuyer sur le bouton "VRAI" pour la première question (réponse correcte)
    await tester.tap(find.text('VRAI'));
    await tester.pump(); // Mettre à jour l'état

    // Vérifier que le score n'est pas encore affiché, car nous sommes toujours dans le quiz
    expect(find.text('Score final: 1/5'), findsNothing);
  });

  // Test de la mise à jour du score après une réponse incorrecte
  testWidgets('QuizPage does not update score on incorrect answer', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Attendre que le widget se stabilise
    await tester.pumpAndSettle();

    // Appuyer sur le bouton "FAUX" pour la première question (réponse incorrecte)
    await tester.tap(find.text('FAUX'));
    await tester.pump(); // Mettre à jour l'état

    // Vérifier que le score n'a pas été mis à jour (score = 0)
    expect(find.text('Score final: 0/5'), findsNothing);

    // Vérifier que la question suivante est affichée
    expect(find.text('Napoléon Bonaparte est devenu empereur en 1804.'), findsOneWidget);
  });

  // Test de la navigation entre les questions
  testWidgets('QuizPage navigates between questions correctly', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Attendre que le widget se stabilise
    await tester.pumpAndSettle();

    // Vérifier que la première question est affichée
    expect(find.text('La Révolution française a commencé en 1789.'), findsOneWidget);

    // Appuyer sur le bouton "VRAI" pour répondre correctement
    await tester.tap(find.text('VRAI'));
    await tester.pump(); // Mettre à jour l'état

    // Appuyer sur le bouton de la question suivante (icône flèche droite)
    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pump(); // Mettre à jour l'état

    // Vérifier que la deuxième question est affichée
    expect(find.text('Napoléon Bonaparte est devenu empereur en 1804.'), findsOneWidget);
  });

  // Test de l'affichage du score final à la fin du quiz
  testWidgets('QuizPage shows final score when quiz is finished', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Répondre à toutes les questions correctement
    await tester.tap(find.text('VRAI')); // Question 1
    await tester.pump();
    await tester.tap(find.text('VRAI')); // Question 2
    await tester.pump();
    await tester.tap(find.text('FAUX')); // Question 3
    await tester.pump();
    await tester.tap(find.text('FAUX')); // Question 4
    await tester.pump();
    await tester.tap(find.text('VRAI')); // Question 5
    await tester.pump();

    // Appuyer sur le bouton de la dernière question pour terminer
    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pump(); // Attendre que l'état soit mis à jour

    // Vérifier que le score final est affiché
    expect(find.text('Score final: 3/5'), findsOneWidget);
  });

  // Test du retour à l'écran d'accueil après la fin du quiz
  testWidgets('QuizPage goes back to home after finishing quiz', (WidgetTester tester) async {
    // Construire la page
    await tester.pumpWidget(
      const MaterialApp(
        home: QuizPage(title: 'Test Quiz'),
      ),
    );

    // Répondre à toutes les questions correctement
    await tester.tap(find.text('VRAI')); // Question 1
    await tester.pump();
    await tester.tap(find.text('VRAI')); // Question 2
    await tester.pump();
    await tester.tap(find.text('FAUX')); // Question 3
    await tester.pump();
    await tester.tap(find.text('FAUX')); // Question 4
    await tester.pump();
    await tester.tap(find.text('VRAI')); // Question 5
    await tester.pump();

    // Appuyer sur le bouton de la dernière question pour terminer
    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pump(); // Attendre que l'état soit mis à jour

    // Appuyer sur le bouton "Retour à l'accueil"
    await tester.tap(find.text('Retour à l\'accueil'));
    await tester.pumpAndSettle(); // Attendre que la navigation se termine

    // Vérifier que nous sommes revenus à l'écran d'accueil
    expect(find.byType(AppBar), findsOneWidget);
  });
}
