import 'package:flutter/material.dart';

class HistorySearchMainView extends StatelessWidget {
  const HistorySearchMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: <Widget>[
      Icon(Icons.construction, size: 72),
      SizedBox(height: 16),
      Text("Currently under construction!",
          style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Text("Please check back later.", style: TextStyle(fontSize: 16))
    ]);
  }
}
