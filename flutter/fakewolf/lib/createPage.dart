import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'GLOBALS.dart';
import 'gamecommunication.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  void _startGame() {
    if(players.length > 2) {
      print("started");
    } else {
      print("Not enough players!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Create Room"),

      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            Text(
              "Your Room-Code is:",
              style: new TextStyle(
                  fontSize: 23.0,
                  color: Colors.black,
                  fontStyle: FontStyle.normal
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)
              ),
              child: Text(
                roomCode,
                style: new TextStyle(
                    fontSize: 27.0,
                    color: Colors.black,
                    fontStyle: FontStyle.normal
                ),
              ),
            ),
            Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  Icon(Icons.people),
                  Text(" Players: "),
                  Text(players.length.toString()),
                  Expanded(child: Container())
                ]
            ),
            Expanded(child: Container(),),
            RaisedButton(
              child: Text("Start Game!", style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () => _startGame(),
            ),
            

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();

    game.addListener((message) {
      if(message["action"] == 'updateRoom')
        setState(() {
          players = message["data"];
        });
    });
  }
}
