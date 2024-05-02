import 'package:flutter/material.dart';

class UnknownItem extends StatelessWidget {
  const UnknownItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error),
          Text("Unknown item", style: TextStyle(fontSize: 18))
        ]);
  }
}
