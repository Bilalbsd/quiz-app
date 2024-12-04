import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.title});
  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Question> _questions = [
    Question(
      questionText: "La Révolution française a commencé en 1789.",
      isCorrect: true,
    ),
    Question(
      questionText: "Napoléon Bonaparte est devenu empereur en 1804.",
      isCorrect: true,
    ),
    Question(
      questionText:
          "La bataille de Verdun a eu lieu pendant la Seconde Guerre mondiale.",
      isCorrect: false,
    ),
    Question(
      questionText: "La prise de la Bastille a marqué la fin du Moyen Âge.",
      isCorrect: false,
    ),
    Question(
      questionText: "Jeanne d'Arc a libéré Orléans en 1429.",
      isCorrect: true,
    ),
  ];

  final List<String> _images = [
    'assets/images/revolution_francaise.jpg',
    'assets/images/napoleon.jpg',
    'assets/images/bataille_verdun.jpg',
    'assets/images/prise_bastille.jpg',
    'assets/images/jeanne_darc.jpg',
  ];

  List<bool> _answeredQuestions = [];

  @override
  void initState() {
    super.initState();
    _answeredQuestions = List.generate(_questions.length, (index) => false);
  }

  void _checkAnswer(bool userChoice) {
    if (!_answeredQuestions[_currentQuestionIndex]) {
      final isCorrect =
          _questions[_currentQuestionIndex].isCorrect == userChoice;
      setState(() {
        _answeredQuestions[_currentQuestionIndex] = true;
        if (isCorrect) _score++;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
          });
        } else {
          _showFinalScore();
        }
      });
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Le Quiz est terminé !'),
        content: Text('Score final: $_score/${_questions.length}'),
        actions: [
          TextButton(
            child: const Text('Retour à l\'accueil'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Retour à l'écran d'accueil
            },
          ),
          TextButton(
            child: const Text('Recommencer'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _answeredQuestions =
                    List.generate(_questions.length, (index) => false);
              });
            },
          ),
        ],
      ),
    );
  }

  void _goToPreviousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAnswered = _answeredQuestions[_currentQuestionIndex];
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Flèche retour
            onPressed: () =>
                Navigator.pop(context), // Retour à l'écran précédent
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                _images[_currentQuestionIndex],
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _questions[_currentQuestionIndex].questionText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _goToPreviousQuestion,
                    icon: const Icon(Icons.arrow_left),
                    color: Colors.blueAccent,
                    iconSize: 36,
                  ),
                  ElevatedButton(
                    onPressed: isAnswered ? null : () => _checkAnswer(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAnswered ? Colors.grey : Colors.blueAccent,
                    ),
                    child: const Text('VRAI'),
                  ),
                  ElevatedButton(
                    onPressed: isAnswered ? null : () => _checkAnswer(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAnswered ? Colors.grey : Colors.blueAccent,
                    ),
                    child: const Text('FAUX'),
                  ),
                  IconButton(
                    onPressed: _goToNextQuestion,
                    icon: const Icon(Icons.arrow_right),
                    color: Colors.blueAccent,
                    iconSize: 36,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
