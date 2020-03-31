import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '',
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String text = '';
  int numTwo = 0;
  int numOne = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preopr = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          margin: EdgeInsets.only(bottom: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  button("C", Colors.grey, 1),
                  button("+/-", Colors.grey, 1),
                  button("%", Colors.grey, 1),
                  button("/", Colors.deepOrange, 1)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  button("7", Colors.white, 1),
                  button("8", Colors.white, 1),
                  button("9", Colors.white, 1),
                  button("X", Colors.deepOrange, 1)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  button("4", Colors.white, 1),
                  button("5", Colors.white, 1),
                  button("6", Colors.white, 1),
                  button("-", Colors.deepOrange, 1)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  button("1", Colors.white, 1),
                  button("2", Colors.white, 1),
                  button("3", Colors.white, 1),
                  button("+", Colors.deepOrange, 1)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  button("0", Colors.white, 0),
                  button('.', Colors.white, 1),
                  button("=", Colors.deepOrange, 1)
                ],
              )
            ],
          )),
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    Container container;
    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(btnTxt, style: TextStyle(fontSize: 30)),
          color: color,
          padding: EdgeInsets.only(left: 81, right: 81, top: 20, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(btnTxt, style: TextStyle(fontSize: 30)),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preopr = '';
    } else if (txtBtn == '=') {
      print(preopr);
      numTwo = int.parse(result);
      switch (preopr) {
        case '+':
          finalResult = add();
          numOne = 0;
          numTwo = 0;
          break;
        case '-':
          finalResult = sub();
          numOne = 0;
          numTwo = 0;
          break;
        case 'X':
          finalResult = mul();
          numOne = 0;
          numTwo = 0;
          break;
        case '/':
          finalResult = div();
          numOne = 0;
          numTwo = 0;
          break;
      }
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'X' ||
        txtBtn == '/') {
      if (numOne == 0) {
        numOne = int.parse(result);
        print(result);
        result = '';
        opr = txtBtn;
        preopr = opr;
      } else {
        numTwo = int.parse(result);
        switch (opr) {
          case '+':
            finalResult = add();
            preopr = opr;
            break;
          case '-':
            finalResult = sub();
            preopr = opr;
            break;
          case 'X':
            finalResult = mul();
            preopr = opr;
            break;
          case '/':
            finalResult = div();
            preopr = opr;
            break;
        }

        preopr = opr;
        opr = txtBtn;
        result = '';
      }
    } else if (txtBtn == '%') {
      numOne = int.parse(result);
      result = (numOne / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if (!result.contains('.')) {
        result += '.';
        finalResult = result;
      }
    } else if (txtBtn == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '' || result == '0') {
        result = txtBtn;
        finalResult = result;
      } else {
        setState(() {
          result = result + txtBtn;
          finalResult = result;
        });
      }
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = int.parse(result);
    return result;
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = int.parse(result);
    return result;
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = int.parse(result);
    return result;
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = int.parse(result);
    return result;
  }
}