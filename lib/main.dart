import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(MealPlanner());
}

//Helper classes
class Meal {
  bool haveHadIt = false;
  String name = '';
  int wait = 120 * 60; //two hours
  IconData icon = Icons.timelapse;
  Color color = Colors.white30;
  double myFontSize = 18;

  Meal({this.name, this.haveHadIt, this.wait, this.color, this.myFontSize});

  String get Name => haveHadIt ? '*' + name + '*' : name;

  IconData get ICON => haveHadIt ? Icons.done : icon;

  Color get MyColor => haveHadIt ? Colors.black12 : color;
}

//Meal Planner page
class MealPlanner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Gadir Feeder',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Beast! Are you hungery yet?'),
    );
  }
}

//Shopping list page
class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Timer _timer;
  bool _timerStarted = false;

  final Meal _coffee = Meal(
      name: 'Coffee Time!',
      haveHadIt: false,
      wait: 3 * 60,
      color: Colors.transparent);
  final Meal _first = Meal(
      name: 'First Meal',
      haveHadIt: false,
      wait: 120 * 60,
      color: Colors.transparent); //120 * 60
  final Meal _second = Meal(
      name: 'Second Meal',
      haveHadIt: false,
      wait: 120 * 60,
      color: Colors.transparent); // 120 * 60
  final Meal _third = Meal(
      name: 'Third Meal',
      haveHadIt: false,
      wait: 120 * 60,
      color: Colors.transparent); //120 * 60
  final Meal _fourth = Meal(
      name: 'Fourth Meal',
      haveHadIt: false,
      wait: 120 * 60,
      color: Colors.transparent); //120 * 60
  final Meal _final = Meal(
      name: 'Final Meal',
      haveHadIt: false,
      wait: 120 * 602,
      color: Colors.transparent); //120 * 60
  //State

  void startMealCounter(Meal m) {
    setState(() async {
      _counter = m.wait;
      m.haveHadIt = false;
      m.myFontSize = 60;
      startTimer(m);
    });
  }

  void _reset() {
    setState(() {
      _coffee.haveHadIt = false;
      _first.haveHadIt = false;
      _second.haveHadIt = false;
      _third.haveHadIt = false;
      _fourth.haveHadIt = false;
      _final.haveHadIt = false;
      _counter = 0;
    });
  }

  void goToShoppingList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => ShoppingList()),
    );
  }

  void startTimer(Meal m) {
    if (!_timerStarted) {
      _timerStarted = true;

      const Duration oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_counter < 1) {
                  timer.cancel();
                  _timerStarted = false;
                  m.haveHadIt = true;
                  m.myFontSize = 18;
                  _showMyDialog(m);
                } else {
                  _counter = _counter - 1;
                }
              }));
    }
  }

  Future<void> _showMyDialog(Meal m) async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            contentTextStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white)),
            title: Text('Hey dude! ' + m.name,
                style: const TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Are you ready for your next treat? you have been waitting for ' +
                          (m.wait / 60).toString() +
                          ' minutes my guy! '),
                  const Text(
                      'Hey do not forget to start the timer for your next meal'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('  Done!  ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        backgroundColor: Colors.redAccent)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final Meal first = _first;
    final Meal second = _second;
    final Meal third = _third;
    final Meal fourth = _fourth;
    final Meal last = _final;
    final Meal coffee = _coffee;

    return Stack(
      children: <Widget>[
        Image.asset(
          'images/agbg.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/agbg.jpg'), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Time Remaining',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),

                Text(
                  '$_counter',
                  style: const TextStyle(color: Colors.white, fontSize: 159),
                  textAlign: TextAlign.center,
                ),
                TextButton.icon(
                    label: Text(coffee.Name),
                    style: TextButton.styleFrom(
                      shadowColor: Colors.black38,
                      textStyle: TextStyle(fontSize: coffee.myFontSize),
                      primary: Colors.white,
                      backgroundColor: coffee.MyColor,
                    ),
                    icon: Icon(coffee.ICON),
                    onPressed: () => startMealCounter(coffee)),
                //First on

                TextButton.icon(
                    label: Text(first.Name),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: first.myFontSize),
                      primary: Colors.white,
                      backgroundColor: first.MyColor,
                      shadowColor: Colors.black26,
                    ),
                    icon: Icon(first.ICON),
                    onPressed: () => startMealCounter(first)),
                //second meal
                TextButton.icon(
                    label: Text(second.Name),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: second.myFontSize),
                        primary: Colors.white,
                        backgroundColor: second.MyColor),
                    icon: Icon(second.ICON),
                    onPressed: () => startMealCounter(second)),
                //3rd meal
                TextButton.icon(
                    label: Text(third.Name),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: third.myFontSize),
                        primary: Colors.white,
                        backgroundColor: third.MyColor),
                    icon: Icon(third.ICON),
                    onPressed: () => startMealCounter(third)),
                //4th meal
                TextButton.icon(
                    label: Text(fourth.Name),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: fourth.myFontSize),
                        primary: Colors.white,
                        backgroundColor: fourth.MyColor),
                    icon: Icon(fourth.ICON),
                    onPressed: () => startMealCounter(fourth)),
                //5th meal
                TextButton.icon(
                    label: Text(last.Name),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: last.myFontSize),
                        primary: Colors.white,
                        backgroundColor: last.MyColor),
                    icon: Icon(last.ICON),
                    onPressed: () => startMealCounter(last)),
                //Reset
                TextButton.icon(
                    label: const Text('Reset'),
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 33),
                        primary: Colors.red,
                        backgroundColor: Colors.transparent),
                    icon: const Icon(Icons.restore),
                    onPressed: _reset),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            //onPressed: _reset,
            onPressed: goToShoppingList,
            tooltip: 'Reset',
            child: const Icon(Icons.add_shopping_cart_outlined),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        )
      ],
    );
  }
}
