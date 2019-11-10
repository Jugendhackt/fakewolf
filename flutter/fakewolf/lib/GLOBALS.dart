import 'dart:math';
import 'package:flutter/material.dart';

import 'gamecommunication.dart';

Player player = Player("Player" + new Random().nextInt(99999).toString());
String roomCode = "000000";
MaterialColor color = Colors.blue;
TextEditingController joinController = new TextEditingController();
TextStyle font = TextStyle(fontSize: 16.0);
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();