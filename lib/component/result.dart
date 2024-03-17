import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final int totalQuestion;
  final int totalScore;
  final VoidCallback resetHandler;

  Results(this.totalQuestion, this.totalScore, this.resetHandler);

  Text checkScore(int totalScore_) {
    String resultScoreTxt = '';
    var resultColor = Colors.red;

    if (totalScore_ == totalQuestion) {
      resultColor = Colors.green;
      resultScoreTxt = "Good Job!";
    } else if (totalScore_ >= 3) {
      resultColor = Colors.yellow;
      resultScoreTxt = "At least you tried!";
    } else {
      resultColor = Colors.red;
      resultScoreTxt = "Oops!";
    }

    return Text(
      resultScoreTxt,
      style: TextStyle(fontSize: 20, color: resultColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Finished!',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Your Score: $totalScore from $totalQuestion',
              style: TextStyle(fontSize: 20),
            ),
            checkScore(totalScore),
            ElevatedButton(
              onPressed: resetHandler,
              child: const Text('Reset Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
