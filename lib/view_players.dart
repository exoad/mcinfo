import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mcinfo_app/api.dart';
import 'package:mcinfo_app/bits.dart';
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
    _controller.text =
        Provider.of<EphemeralPlayerSearchProvider>(context)
            .searchQuery;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(children: <Widget>[
            Icon(Ionicons.person),
            SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                    ]),
              ),
            )
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
              child:
                  Provider.of<EphemeralPlayerSearchProvider>(context)
                          .searchQuery
                          .isNotEmpty
                      ? FutureBuilder<PlayerData?>(
                          future: MinecraftApi.fetch(Provider.of<
                                      EphemeralPlayerSearchProvider>(
                                  context)
                              .searchQuery),
                          builder: (BuildContext context,
                              AsyncSnapshot<PlayerData?> snapshot) {
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
                                          fontWeight:
                                              FontWeight.w500)),
                                ],
                              );
                            } else {
                              return Center(
                                child: snapshot.data == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                            Icon(Ionicons.sad_outline,
                                                size: 64),
                                            SizedBox(height: 16),
                                            Text("Nothing found...",
                                                style: TextStyle(
                                                    fontSize: 20)),
                                          ])
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child:
                                                BigPlayerTextureDisplay(
                                                    playerData:
                                                        snapshot
                                                            .data!),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                children: <Widget>[
                                                  Text.rich(TextSpan(
                                                      children: <InlineSpan>[
                                                        WidgetSpan(
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                              SizedBox(
                                                                  height:
                                                                      48,
                                                                  width:
                                                                      48,
                                                                  child:
                                                                      snapshot.data!.minersAvatar.helmAvatar ?? const SizedBox.shrink()),
                                                              const SizedBox(
                                                                  width:
                                                                      16),
                                                              Text.rich(TextSpan(
                                                                  children: <TextSpan>[
                                                                    const TextSpan(text: "Player \n", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                                                                    TextSpan(text: Provider.of<EphemeralPlayerSearchProvider>(context).searchQuery, style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 22, fontWeight: FontWeight.bold)),
                                                                  ]))
                                                            ])),
                                                        const TextSpan(
                                                            text:
                                                                "\n\nUUID\n",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12,
                                                                fontWeight:
                                                                    FontWeight.normal)),
                                                        TextSpan(
                                                            text:
                                                                "${snapshot.data!.uuid}\n\n",
                                                            style: const TextStyle(
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                fontSize:
                                                                    14,
                                                                fontWeight:
                                                                    FontWeight.bold)),
                                                        const TextSpan(
                                                            text:
                                                                "Username history\n",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12,
                                                                fontWeight:
                                                                    FontWeight.normal)),
                                                        TextSpan(
                                                            text: snapshot
                                                                    .data!
                                                                    .nameHistory
                                                                    .isNotEmpty
                                                                ? "${snapshot.data!.nameHistory.map((Name name) => name.name).join(",\n")}\n"
                                                                : "No previous usernames\n\n",
                                                            style: const TextStyle(
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                fontSize:
                                                                    14,
                                                                fontWeight:
                                                                    FontWeight.bold)),
                                                      ])),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: 6),
                                              Wrap(
                                                  runAlignment:
                                                      WrapAlignment
                                                          .start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment
                                                          .start,
                                                  runSpacing: 8,
                                                  spacing: 8,
                                                  children: <Widget>[
                                                    TextButton(
                                                        onPressed:
                                                            () {
                                                          if (snapshot
                                                                  .data!
                                                                  .uuid !=
                                                              null) {
                                                            Clipboard.setData(ClipboardData(
                                                                text: snapshot
                                                                    .data!
                                                                    .uuid!));
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content:
                                                                  Row(
                                                                children: <Widget>[
                                                                  Icon(Ionicons.checkmark_done_circle,
                                                                      color: Colors.green),
                                                                  SizedBox(width: 8),
                                                                  Text("UUID copied to clipboard"),
                                                                ],
                                                              ),
                                                              showCloseIcon:
                                                                  true,
                                                              duration:
                                                                  Duration(milliseconds: 800),
                                                            ));
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Copy Uuid",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14))),
                                                    TextButton(
                                                        onPressed:
                                                            () {
                                                          if (snapshot
                                                                  .data!
                                                                  .uuid !=
                                                              null) {
                                                            Clipboard.setData(ClipboardData(
                                                                text: snapshot
                                                                    .data!
                                                                    .username));
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content:
                                                                  Row(
                                                                children: <Widget>[
                                                                  Icon(Ionicons.checkmark_done_circle,
                                                                      color: Colors.green),
                                                                  SizedBox(width: 8),
                                                                  Text("Username copied to clipboard"),
                                                                ],
                                                              ),
                                                              showCloseIcon:
                                                                  true,
                                                              duration:
                                                                  Duration(milliseconds: 800),
                                                            ));
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Copy username",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14)))
                                                  ])
                                            ],
                                          ),
                                        ],
                                      ),
                              );
                            }
                          })
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
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

class BigPlayerTextureDisplay extends StatefulWidget {
  final PlayerData playerData;

  const BigPlayerTextureDisplay(
      {super.key, required this.playerData});

  @override
  State<BigPlayerTextureDisplay> createState() =>
      _BigPlayerTextureDisplayState();
}

class _BigPlayerTextureDisplayState
    extends State<BigPlayerTextureDisplay> {
  late List<Image> images;
  late int selected;
  bool hoveringMain = false;

  @override
  void initState() {
    super.initState();
    selected = 0;
    images = <Image>[
      widget.playerData.frontBody,
      if (widget.playerData.minersAvatar.flatAvatar != null)
        widget.playerData.minersAvatar.flatAvatar!,
      if (widget.playerData.minersAvatar.helmAvatar != null)
        widget.playerData.minersAvatar.helmAvatar!,
      if (widget.playerData.minersAvatar.isometricAvatar != null)
        widget.playerData.minersAvatar.isometricAvatar!,
      if (widget.playerData.minersAvatar.flatFrontBody != null)
        widget.playerData.minersAvatar.flatFrontBody!,
      if (widget.playerData.minersAvatar.helmFrontBody != null)
        widget.playerData.minersAvatar.helmFrontBody!,
      if (widget.playerData.minersAvatar.flatBust != null)
        widget.playerData.minersAvatar.flatBust!,
      if (widget.playerData.minersAvatar.helmBust != null)
        widget.playerData.minersAvatar.helmBust!,
      if (widget.playerData.minersAvatar.userSkin != null)
        widget.playerData.minersAvatar.userSkin!,
    ];
  }

  @override
  void dispose() {
    images = <Image>[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      MouseRegion(
        onEnter: (PointerEnterEvent _) =>
            setState(() => hoveringMain = true),
        onExit: (PointerExitEvent _) =>
            setState(() => hoveringMain = false),
        child: Stack(children: <Widget>[
          Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: images[selected]),
          ),
          Center(
            child: AnimatedOpacity(
                opacity: hoveringMain ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: const Icon(Ionicons.save),
                    label: const Text("Download"))),
          )
        ]),
      ),
      const SizedBox(height: 8),
      Wrap(
          runSpacing: 8,
          spacing: 8,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (int i = 0; i < images.length; i++)
              if (i != selected)
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.4),
                          width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: SizedBox.square(
                      dimension: 56,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => setState(() => selected = i),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: images[i],
                          ),
                        ),
                      )),
                )
              else
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primary,
                          width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: SizedBox.square(
                      dimension: 66,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => setState(() => selected = i),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: images[i],
                          ),
                        ),
                      )),
                )
          ])
    ]);
  }
}
