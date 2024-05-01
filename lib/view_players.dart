import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PlayerSearchMainView extends StatefulWidget {
  const PlayerSearchMainView({super.key});

  @override
  State<PlayerSearchMainView> createState() =>
      _PlayerSearchMainViewState();
}

class _PlayerSearchMainViewState extends State<PlayerSearchMainView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(children: <Widget>[
            Icon(Ionicons.person),
            SizedBox(width: 8),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Search for a player",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  Text("Input a player name to start searching",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize:
                              14)), // we could do better with a span but aight
                ])
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Player name",
                          border: OutlineInputBorder())),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    icon: const Icon(Ionicons.compass)),
              ],
            ),
          ),
          const Divider(),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Ionicons.sad_outline, size: 64),
                    SizedBox(height: 16),
                    Text("Nothing found...",
                        style: TextStyle(fontSize: 20)),
                  ]),
            ),
          )
        ]);
  }

  @override
  bool get wantKeepAlive => true;
}
