import 'package:flutter/material.dart';
import 'dart:math';
void main(){
  runApp(calculadorApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculadora Científica',
      // theme: ThemeData(
        
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Scaffold(appBar: AppBar(title: const Text('Calculadora Científica')),
    body: Padding(padding: const EdgeInsets.all(16),
    child: TextField(controller: myController),
    ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(myController.text),
        );
      },
      );
    },
    tooltip: 'Show me the value',
    child: const Icon(Icons.text_fields),
    ),
    );
  }
}

/////////////////////////

class calculadorApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Científica',
      home: CalculatorScreen(),
    );
  }
}
class CalculatorScreen extends StatefulWidget{
  @override
  _CalculatorScreenState createState()=> _CalculatorScreenState();
}
class _CalculatorScreenState extends State<CalculatorScreen>{
  String _display='0';
  double _firstNumber=0;
  String _operator='';
  bool _shouldClear=false;
  void _numClick(String text) {
    setState(() {
      if (_shouldClear) {
        _display = text;
        _shouldClear = false;
      } else {
        if (_display == '0') {
          _display = text;
        } else {
          _display += text;
        }
      }
    });
  }
  void _clear() {
    setState(() {
      _display = '0';
      _firstNumber = 0;
      _operator = '';
      _shouldClear = false;
    });
  }
  void _setOperator(String op) {
    _firstNumber = double.tryParse(_display) ?? 0;
    _operator = op;
    _shouldClear = true;
  }
  void _calculate() {
    double secondNumber = double.tryParse(_display) ?? 0;
    double result = 0;
    switch (_operator) {
      case '+':
        result = _firstNumber + secondNumber;
        break;
      case '-':
        result = _firstNumber - secondNumber;
        break;
      case '*':
        result = _firstNumber * secondNumber;
        break;
      case '/':
        result = secondNumber != 0 ? _firstNumber / secondNumber : double.nan;
        break;
    }
    setState(() {
      _display = result.toString();
      _operator = '';
      _shouldClear = true;
    });
  }
  void _sin(){
    double value=double.tryParse(_display)?? 0;
    double result=sin(value);
    setState(() {
      _display=result.toString();
      _shouldClear=true;
    });
  }
  void _ln(){
    double value=double.tryParse(_display)?? 0;
    double result=value>0 ? log(value): double.nan;
    setState(() {
      _display=result.toString();
      _shouldClear=true;
    });
  }
  void _cos(){
    double value=double.tryParse(_display)?? 0;
    double result=cos(value);
    setState(() {
      _display=result.toString();
      _shouldClear=true;
    });
  }
  void _tan(){
    double value=double.tryParse(_display)?? 0;
    double result=tan(value);
    setState(() {
      _display=result.toString();
      _shouldClear=true;
    });
  }
  void _sqrt() {
    double value = double.tryParse(_display) ?? 0;
    double result = value >= 0 ? sqrt(value) : double.nan;
    setState(() {
      _display = result.toString();
      _shouldClear = true;
    });
  }
  void _pow() {
    double value = double.tryParse(_display) ?? 0;
    double result = pow(value, 2).toDouble();
    setState(() {
      _display = result.toString();
      _shouldClear = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Científica'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _numClick('7'), child: Text('7')),
              ElevatedButton(onPressed: () => _numClick('8'), child: Text('8')),
              ElevatedButton(onPressed: () => _numClick('9'), child: Text('9')),
              ElevatedButton(onPressed: () => _setOperator('/'), child: Text('/')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _numClick('4'), child: Text('4')),
              ElevatedButton(onPressed: () => _numClick('5'), child: Text('5')),
              ElevatedButton(onPressed: () => _numClick('6'), child: Text('6')),
              ElevatedButton(onPressed: () => _setOperator('*'), child: Text('*')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _numClick('1'), child: Text('1')),
              ElevatedButton(onPressed: () => _numClick('2'), child: Text('2')),
              ElevatedButton(onPressed: () => _numClick('3'), child: Text('3')),
              ElevatedButton(onPressed: () => _setOperator('-'), child: Text('-')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _clear(), child: Text('C')),
              ElevatedButton(onPressed: () => _numClick('0'), child: Text('0')),
              ElevatedButton(onPressed: () => _calculate(), child: Text('=')),
              ElevatedButton(onPressed: () => _setOperator('+'), child: Text('+')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: _sin, child: Text('sin')),
              ElevatedButton(onPressed: _ln, child: Text('ln')),
              ElevatedButton(onPressed: _cos, child: Text('cos')),
              ElevatedButton(onPressed: _tan, child: Text('tan')),
              ElevatedButton(onPressed: _sqrt, child: Text('√')),
              ElevatedButton(onPressed: _pow, child: Text('x²')),
            ],
          ),














        ],
      ),
    );
  }
}

