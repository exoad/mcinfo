import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mcinfo_app/bits.dart';
import 'package:mcinfo_app/shared.dart';
import 'package:mcinfo_app/view_about.dart';
import 'package:mcinfo_app/view_history.dart';
import 'package:mcinfo_app/view_players.dart';
import 'package:mcinfo_app/view_servers.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MinersAvatarApi.fetch(
      url: MinersAvatarApi.flatAvatar, username: "exoad");

  runApp(MultiProvider(providers: <ChangeNotifierProvider<dynamic>>[
    ChangeNotifierProvider<AppNavbarSelectedIndexProvider>(
      create: (_) => AppNavbarSelectedIndexProvider(),
    ),
    ChangeNotifierProvider<AppThemeModeProvider>(
        create: (_) => AppThemeModeProvider())
  ], child: const AppEntryRoot()));
}

class AppEntryRoot extends StatefulWidget {
  const AppEntryRoot({super.key});

  @override
  State<AppEntryRoot> createState() => _AppEntryRootState();
}

class _AppEntryRootState extends State<AppEntryRoot> {
  final List<Widget> _views = const <Widget>[
    PlayerSearchMainView(),
    ServerSearchMainView(),
    HistorySearchMainView(),
    AboutMainView() // dont fucking mess up these ordering and sizing of this _views array
  ];

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode =
        Provider.of<AppThemeModeProvider>(context).themeMode;
    return MaterialApp(
      theme: switch (themeMode) {
        ThemeMode.light => AdwaitaThemeData.light(),
        _ => AdwaitaThemeData.dark()
      },
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<AppThemeModeProvider>(context).themeMode,
      home: Scaffold(
        body: SafeArea(
          child: Row(children: <Widget>[
            const AppNavRailPartition(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _views[
                  Provider.of<AppNavbarSelectedIndexProvider>(context)
                      .selectedIndex],
            ))
          ]),
        ),
      ),
    );
  }
}

class ThemeChangerLead extends StatefulWidget {
  const ThemeChangerLead({super.key});

  @override
  State<ThemeChangerLead> createState() => _ThemeChangerLeadState();
}

class _ThemeChangerLeadState extends State<ThemeChangerLead> {
  @override
  Widget build(BuildContext context) {
    ThemeMode mode =
        Provider.of<AppThemeModeProvider>(context).themeMode;
    return IconButton(
        onPressed: () =>
            Provider.of<AppThemeModeProvider>(context, listen: false)
                .themeMode = switch (mode) {
              ThemeMode.light => ThemeMode.dark,
              _ => ThemeMode.light
            },
        icon: switch (mode) {
          ThemeMode.light => const Icon(Ionicons.moon),
          _ => const Icon(Ionicons.sunny)
        });
  }
}

class AppNavRailPartition extends StatefulWidget {
  const AppNavRailPartition({
    super.key,
  });

  @override
  State<AppNavRailPartition> createState() =>
      _AppNavRailPartitionState();
}

class _AppNavRailPartitionState extends State<AppNavRailPartition> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        onDestinationSelected: (int i) =>
            Provider.of<AppNavbarSelectedIndexProvider>(context,
                    listen: false)
                .selectedIndex = i,
        labelType: NavigationRailLabelType.all,
        groupAlignment: 0,
        leading: const ThemeChangerLead(),
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
              icon: Icon(Ionicons.person_circle_outline),
              label: Text("Players")),
          NavigationRailDestination(
              icon: Icon(Ionicons.server_outline),
              label: Text("Servers")),
          NavigationRailDestination(
              icon: Icon(Ionicons.compass_outline),
              label: Text("History")),
          NavigationRailDestination(
              icon: Icon(Ionicons.information_circle_outline),
              label: Text("About")),
        ],
        selectedIndex:
            Provider.of<AppNavbarSelectedIndexProvider>(context)
                .selectedIndex);
  }
}
