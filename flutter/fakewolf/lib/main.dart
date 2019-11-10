import 'package:fakewolf/phases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


/*@override
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
								padding: EdgeInsets.all(15),
								decoration: BoxDecoration(
									border: Border.all(color: Colors.grey[500], width: 1.0),
									color: Colors.grey[300],
									borderRadius: BorderRadius.all(new Radius.circular(10)),
									boxShadow: <BoxShadow>[BoxShadow(
										color: Colors.grey[600],
										offset: Offset(3, 3),
										blurRadius: 2,
										spreadRadius: 3,
									)],
								),
								child: Text(widget.player.cards[i].description)
							),
						);
					}),
			),
		);*/