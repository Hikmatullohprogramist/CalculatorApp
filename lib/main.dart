// ignore_for_file: prefer_const_constructors
import 'package:datepicker_1/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '0';
  var userAnswer = '0';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF17181A),
              Color(0xFF17181A),
            ],
          )),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Center(
                    child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = '';
                              });
                            },
                            color: Color(0xFF616161),
                            textcolor: Color(0xFFA5A5A5),
                            buttonText: buttons[index],
                          );
                        }
                        // Equal Button
                        if (index == buttons.length - 1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            color: Color(0xFF1991FF),
                            textcolor: Color(0xFFB2DAFF),
                            buttonText: buttons[index],
                          );
                        }
                        //////////////////////////////////////////
                        else if (index == 1) {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                                if (userQuestion == '') {
                                  userQuestion = '0';
                                }
                              });
                            },
                            ikonka: Icon(Icons.backspace),
                            color: Color(0xFF616161),
                            textcolor: Color(0xFFA5A5A5),
                            buttonText: buttons[index],
                          );
                        } else {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            color: isOperator(buttons[index])
                                ? Color(0xFF005DB2)
                                : Color(0xFF303136),
                            textcolor: isOperator(buttons[index])
                                ? Color(0xFF339DFF)
                                : Color(0xFF29A8FF),
                            buttonText: buttons[index],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestions = userQuestion;
    finalQuestions = finalQuestions.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestions);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
