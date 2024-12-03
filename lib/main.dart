import 'package:flutter/material.dart';

import 'QuizBrain.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black26,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreWidgets = [];

  final quizBrain = QuizBrain();
  int currentQuestion = 0;

  Future<String?> showFinishedScreen() {
    final int numberCorrect =
        scoreWidgets.where((icon) => icon.icon == Icons.check).length;

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text('Quiz Over!'),
                content: Text("Congratulations on completing the quiz!\n"
                    "You answered $numberCorrect out of "
                    "${quizBrain.howManyQuestions} Questions correct!"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        setState(() {
                          scoreWidgets = [];
                        });
                      },
                      child: const Text("Try Again?")),
                ]));
  }

  void onCorrectAnswer() {
    setState(() {
      scoreWidgets = [
        ...scoreWidgets,
        const Icon(
          Icons.check,
          color: Colors.green,
        )
      ];
    });
    if (quizBrain.questionsLeft == 1) {
      showFinishedScreen();
    }
    quizBrain.nextQuestion();
  }

  void onIncorrectAnswer() {
    setState(() {
      scoreWidgets = [
        ...scoreWidgets,
        const Icon(
          Icons.cancel,
          color: Colors.red,
        )
      ];
    });
    if (quizBrain.questionsLeft == 1) {
      showFinishedScreen();
    }
    quizBrain.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.currentQuestion.questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            )),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green)),
                    onPressed: () {
                      if (quizBrain.isRightAnswer(true)) {
                        onCorrectAnswer();
                      } else {
                        onIncorrectAnswer();
                      }
                    },
                    child: const Text(
                      "True",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      if (quizBrain.isRightAnswer(false)) {
                        onCorrectAnswer();
                      } else {
                        onIncorrectAnswer();
                      }
                    },
                    child: const Text(
                      "False",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )))),
        Row(
          children: scoreWidgets,
        )
      ],
    );
  }
}
