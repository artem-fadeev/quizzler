import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[600],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizePage(),
          ),
        ),
      ),
    );
  }
}

class QuizePage extends StatefulWidget {
  @override
  _QuizePageState createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizePage> {
  List<Icon> scoreKeeper = [];

  var alertStyle = AlertStyle(
    isCloseButton: false,
  );

  void checkAnswer(bool selectedAnswear) {
    setState(() {
      if (quizBrain.getQuestionAnswer() == selectedAnswear) {
        quizBrain.updateResult('correct');
        this.scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        quizBrain.updateResult('failed');
        this.scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      if (quizBrain.isFinished()) {
        Alert(
            context: context,
            style: alertStyle,
            title: 'Finished!',
            desc: 'Your result is:',
            content: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check, color: Colors.green),
                    Text(quizBrain.getResult('correct')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.close, color: Colors.red),
                    Text(quizBrain.getResult('failed')),
                  ],
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Repeat",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        quizBrain.nextQuestion();
      }
    });
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
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
