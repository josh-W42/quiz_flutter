class Question {
  final String _questionText;
  final bool _questionAnswer;
  Question(this._questionText, this._questionAnswer);

  @override
  String toString() {
    return '$_questionText-$_questionAnswer';
  }

  get questionText {
    return _questionText;
  }

  get questionAnswer {
    return _questionAnswer;
  }
}
