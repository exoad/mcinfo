import 'package:dart_minecraft/dart_minecraft.dart' as minecraft;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcinfo_app/shared.dart';

class MinecraftApi {
  MinecraftApi._();

  static Future<String?> getUuid(String username) async {
    String? uuid;
    print("Fetching UUID for $username");
    uuid = (await minecraft.getUuid(username)).second;
    return uuid;
  }

  static Future<PlayerData?> fetch(String username) async {
    print("New fetch order for $username");
    String? uuid = await getUuid(username);
    if (uuid != null) {
      print("UUID fetch received NON-NULL value: $uuid");
      List<minecraft.Name> nameHistory =
          <minecraft.Name>[]; // deprecated
      MinersAvatarApiResponse minersAvatar =
          await MinersAvatarApi.fetch(username);
      print("Fetching full-bodyRes");
      http.Response fullBodyres = await http.get(Uri.https(
          "https://api.mineatar.io/body/full/$uuid?scale=8"));
      Image fullBody =
          Image.memory(Uint8List.fromList(fullBodyres.bodyBytes));
      print("Full body fetched for $username. Returning now...");
      return (
        username: username,
        uuid: uuid,
        cape: null,
        frontBody: fullBody,
        nameHistory: nameHistory,
        minersAvatar: minersAvatar
      );
    } else {
      print("UUID fetch received NULL value: $uuid");
      return null;
    }
  }
}

typedef PlayerData = ({
  String username,
  String? uuid,
  List<minecraft.Name> nameHistory,
  Image frontBody,
  Image? cape,
  MinersAvatarApiResponse minersAvatar
});
