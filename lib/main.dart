import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icalc/Bloc/Result_State.dart';
import 'package:icalc/Bloc/Result_cubit.dart';
import 'package:icalc/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider<ResultCubit>(
      create: (context) => ResultCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const calculator(),
      ),
    );
  }
}

class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  var userInput = '';
  var answer = '0';
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "iCalc",
          style: TextStyle(fontFamily: 'Beginner', fontSize: 50),
        ),
      ), //AppBar
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BlocBuilder<ResultCubit, ResultState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      state.inputString,
                      style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Beginner',
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  );
                },
              ),
              BlocListener<ResultCubit, ResultState>(
                listener: (context, state) {
                  if (state is ResultStateEqualPressed) {
                    state.resultString = state.resultStringFinal;
                  }
                },
                child: BlocBuilder<ResultCubit, ResultState>(
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        state.resultString,
                        style: const TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Beginner',
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: BlocBuilder<ResultCubit, ResultState>(
              builder: (context, state) {
                return GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return customButton(
                        buttonTaped: () {
                          setState(
                            () {
                              state.inputString = '';
                              state.resultString = '0';
                            },
                          );
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return customButton(
                        buttonTaped: () {},
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return customButton(
                        buttonTaped: () {
                          setState(
                            () {
                              state.inputString += buttons[index];
                            },
                          );
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return customButton(
                        buttonTaped: () {
                          setState(
                            () {
                              state.inputString = state.inputString.substring(
                                0,
                                state.inputString.length - 1,
                              );
                            },
                          );
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return customButton(
                        buttonTaped: () {
                          setState(
                            () {
                              BlocProvider.of<ResultCubit>(context)
                                  .equalButtonPressed(state.inputString);
                            },
                          );
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    } else {
                      return customButton(
                        buttonTaped: () {
                          setState(
                            () {
                              state.inputString += buttons[index];
                            },
                          );
                        },
                        buttonText: buttons[index],
                        color: BlocProvider.of<ResultCubit>(context)
                                .isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: BlocProvider.of<ResultCubit>(context)
                                .isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
