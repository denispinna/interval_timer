import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ImageButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  ImageButton(this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: Colors.deepOrange,
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
        ),
      ),
    );
  }
}