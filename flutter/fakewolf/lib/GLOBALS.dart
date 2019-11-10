import 'dart:math';
import 'package:flutter/material.dart';

String playerName = "Player" + new Random().nextInt(99999).toString();
String roomCode = "000000";
MaterialColor color = Colors.blue;
TextEditingController joinController = new TextEditingController();