import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcinfo_app/shared.dart';

class MinecraftApi {
  MinecraftApi._();

  static Future<String?> getUuid(String username) async {
    String? uuid;
    try {
      print("Fetching UUID for $username");
      uuid = await getUuid(username);
    } catch (err) {
      throw err;
    }
    return uuid;
  }

  static Future<PlayerData?> fetch(String username) async {
    print("New fetch order for $username");
    String? uuid = await getUuid(username);
    if (uuid != null) {
      print("UUID fetch received NON-NULL value: $uuid");
      List<Name> nameHistory = <Name>[]; // deprecated
      MinersAvatarApiResponse minersAvatar =
          await MinersAvatarApi.fetch(username);
      http.Response fullBodyres = await http.get(Uri.https(
          "https://api.mineatar.io/body/full/$uuid?scale=8"));
      Image fullBody =
          Image.memory(Uint8List.fromList(fullBodyres.bodyBytes));
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
  List<Name> nameHistory,
  Image frontBody,
  Image? cape,
  MinersAvatarApiResponse minersAvatar
});
