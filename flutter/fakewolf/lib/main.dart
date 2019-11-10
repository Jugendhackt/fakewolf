import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gamecommunication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "Chat",
			theme: ThemeData(
				primaryColor: Colors.blueGrey,
			),
			home: PhaseOne(),
		);
	}
}

class Player {
	String name;
	List<NewsCard> cards;

	Player(this.name) {
		cards = <NewsCard>[testCard(), testCard()];
	}

	NewsCard testCard() {
		return NewsCard(
			"This is a test Text. This is only used to make this application work and see if it supports automatic multiline text.",
			<String>["Test", "is", "work"],
		);
	}
}

final font = TextStyle(fontSize: 16.0);


class NewsCard {
	String description;
	List<String> keywords;

	NewsCard(this.description, this.keywords);
}

class PhaseOne extends StatefulWidget {

	final player = Player("Test");

	@override
	State<StatefulWidget> createState() => PhaseOneState();
}

class PhaseOneState extends State<PhaseOne> {

	int selected = -1;

	@override
	void initState() {
		super.initState();

		///
		/// Ask to be notified when messages related to the game
		/// are sent by the server
		///
		game.addListener(_onGameDataReceived);
		game.send("test", "test");
	}

	@override
	void dispose() {
		game.removeListener(_onGameDataReceived);
		super.dispose();
	}

	_onGameDataReceived(message) {
		switch (message["action"]) {
			case "cards":
				Map<String, List<String>> cards = message["data"];
				widget.player.cards = List<NewsCard>.generate(cards.length, (i) {
					return NewsCard(
							cards.keys.toList()[i], cards[cards.keys.toList()[i]]);
				});
				print(widget.player.cards);
				break;
			default:
				print(message);
		}
	}

	final appBar = AppBar(
		elevation: 0.1,
		backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
		title: Text("Kartenwahl"),
		actions: <Widget>[
			IconButton(
				icon: Icon(Icons.list),
				onPressed: () {
					print("Pressed list in AppBar");
				},
			)
		],
	);

	void sendSelected() {
		//TODO: send selectedCard to web-socket
		//format: {"type":"playCard","data":{"index":widget.selected}}
		game.send("playCard", selected.toString());
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: appBar,
			body: Padding(
				padding: EdgeInsets.all(30.0),
				child: ListView.builder(
						itemCount: widget.player.cards.length,
						itemBuilder: (BuildContext context, int i) {
							return Container(
								padding: EdgeInsets.only(bottom: 15.0),
								child: Container(
									child: Card(
											shape: selected != i ?
											null //RoundedRectangleBorder(side: BorderSide(color: Colors.teal[300], width: 2))
													:
											RoundedRectangleBorder(
													side: BorderSide(color: Colors.green[400], width: 2)),
											elevation: 1.8,
											color: Colors.grey[300],
											child: InkWell(
												onTap: () =>
														setState(() {
															selected = i;
														}),
												splashColor: Colors.green[800],
												radius: 300,
												child: Container(
													padding: EdgeInsets.all(15),
													child: Text(widget.player.cards[i].description,
															style: font),
												),

											)
									),
								),
							);
						}),
			),
		);
	}
}