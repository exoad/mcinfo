import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mcinfo_app/bits.dart';
import 'package:mcinfo_app/shared.dart';
import 'package:provider/provider.dart';

class PlayerSearchMainView extends StatefulWidget {
  const PlayerSearchMainView({super.key});

  @override
  State<PlayerSearchMainView> createState() =>
      _PlayerSearchMainViewState();
}

class _PlayerSearchMainViewState extends State<PlayerSearchMainView>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                Expanded(
                  child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          hintText: "Player name",
                          border: OutlineInputBorder())),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () =>
                        Provider.of<EphemeralPlayerSearchProvider>(
                                context,
                                listen: false)
                            .searchQuery = _controller.text,
                    icon: const Icon(Ionicons.compass)),
              ],
            ),
          ),
          const Divider(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Provider.of<EphemeralPlayerSearchProvider>(
                          context)
                      .searchQuery
                      .isNotEmpty
                  ? FutureBuilder<MinersAvatarApiResponse>(
                      future: MinersAvatarApi.fetch(
                          Provider.of<EphemeralPlayerSearchProvider>(
                                  context)
                              .searchQuery),
                      builder: (BuildContext context,
                          AsyncSnapshot<MinersAvatarApiResponse>
                              snapshot) {
                        if (snapshot.hasError ||
                            snapshot.connectionState !=
                                ConnectionState.done) {
                          return Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: <Widget>[
                              const CircularProgressIndicator(),
                              const SizedBox(height: 8),
                              Text(
                                  "Querying user \"${Provider.of<EphemeralPlayerSearchProvider>(context).searchQuery}\"",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          );
                        } else {
                          return Center(
                            child: Padding(
                                padding: const EdgeInsets.all(60.0),
                                child: Row(

                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.48,
                                            child: snapshot
                                                .data!.helmFrontBody),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        }
                      })
                  : const Column(
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
