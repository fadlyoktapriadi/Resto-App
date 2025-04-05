import 'package:flutter/material.dart';

enum RestoColor {

  orangeAccent("OrangeAccent", Colors.orangeAccent);

  const RestoColor(this.name, this.color);

  final String name;
  final Color color;
}