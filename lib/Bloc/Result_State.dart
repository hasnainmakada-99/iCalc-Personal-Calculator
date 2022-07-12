class ResultState {
  String resultString;
  String inputString;
  ResultState({
    required this.resultString,
    required this.inputString,
  });
}

class ResultStateEqualPressed extends ResultState {
  String resultStringFinal;
  ResultStateEqualPressed({required this.resultStringFinal})
      : super(
          inputString: '',
          resultString: '',
        );
}
