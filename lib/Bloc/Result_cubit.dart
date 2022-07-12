import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icalc/Bloc/Result_State.dart';
import 'package:math_expressions/math_expressions.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultState(resultString: '0', inputString: '0'));

  bool isOperator(String operatorText) {
    if (operatorText == '/' ||
        operatorText == 'x' ||
        operatorText == '+' ||
        operatorText == '-' ||
        operatorText == '=') {
      return true;
    }
    return false;
  }

  void equalButtonPressed(String inputText) {
    String userInput = inputText;
    userInput = userInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(userInput);
    ContextModel model = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, model);
    state.resultString = eval.toString();
    final resultStringText = state.resultString;
    emit(ResultStateEqualPressed(resultStringFinal: resultStringText));
  }
}
