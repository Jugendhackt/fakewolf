import 'package:flutter/material.dart';

import 'GLOBALS.dart';
import 'createPage.dart';
import 'gamecommunication.dart';
import 'joinPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'FakeWolf',
			theme: ThemeData(
				primarySwatch: color,
				fontFamily: 'Arial',
			),
			navigatorKey: navigatorKey,
			home: StartPage(title: 'FakeWolf'),
		);
	}
}

class StartPage extends StatefulWidget {
	StartPage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

	void _createRoom() async {
		setState(() {
			game.send("createRoom", player.name);
			Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
				return CreatePage();
			}));
		});
	}

	void _joinRoom() {
		setState(() {
			Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
				return JoinPage();
			}));
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Expanded(child: Container()),
						RaisedButton(
							child: Text("Create Room", style: TextStyle(color: Colors.white)),
							color: Colors.blue,
							onPressed: () => _createRoom(),
						),
						RaisedButton(
							child: Text("Join Room", style: TextStyle(color: Colors.white)),
							color: Colors.blue,
							onPressed: () => _joinRoom(),
						),
						Expanded(child: Container()),
						Text("Your name is: $playerName",
							style: new TextStyle(
								fontSize: 17.0,
								color: Colors.black,
							),),
					],
				),
			),
		);
	}
}
