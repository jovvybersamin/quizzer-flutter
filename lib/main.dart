import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  int questionNumber = 0;

  void answerSelected(bool correctAnswer) {
    bool isCorrect =
        correctAnswer == quizBrain.getQuestionAnswer(questionNumber);
    setState(() {
      questionNumber++;
      scoreKeeper.add(isCorrect
          ? Icon(Icons.check, color: Colors.green)
          : Icon(Icons.close, color: Colors.red));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizBrain.isNoQuestions(questionNumber)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'All questions are answered!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: scoreKeeper,
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Text(
                'RESET',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper = [];
                  questionNumber = 0;
                });
              },
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(questionNumber),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                answerSelected(true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                answerSelected(false);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: scoreKeeper,
            ),
          ),
        )
      ],
    );
  }
}
