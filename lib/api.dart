import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http_requests/http_requests.dart';
import 'package:mcinfo_app/shared.dart';

class MinecraftApi {
  MinecraftApi._();

  static Future<bool> get isApiAlive async =>
      (await Mojang.checkStatus()).mojangApi ==
      MojangSiteStatus.available;

  static Future<String?> getUuid(String username) async {
    Pair<String, String> uuid;
    try {
      uuid = await Mojang.getUuid(username);
    } catch (err) {
      return null;
    }
    return uuid.second;
  }

  static Future<List<Name>> getNameHistoryFromUuid(
      String uuid) async {
    try {
      return await Mojang.getNameHistory(uuid);
    } catch (err) {
      return <Name>[];
    }
  }

  static Future<List<Name>> getNameHistoryFromName(
      String username) async {
    String? uuid = await getUuid(username);
    return uuid == null
        ? <Name>[]
        : await getNameHistoryFromUuid(uuid);
  }

  static Future<Profile?> getProfileFromUuid(String uuid) async {
    try {
      return await Mojang.getProfile(uuid);
    } catch (err) {
      return null;
    }
  }

  static Future<PlayerData?> fetch(String username) async {
    String? uuid = await getUuid(username);
    if (uuid != null) {
      print("UUID fetch received NON-NULL value: $uuid");
      List<Name> nameHistory = await getNameHistoryFromUuid(uuid);
      Profile? profile = await getProfileFromUuid(uuid);
      MinersAvatarApiResponse minersAvatar =
          await MinersAvatarApi.fetch(username);
      HttpResponse fullBodyres = await HttpRequests.get(
          "https://api.mineatar.io/body/full/$uuid?scale=8");
      Image fullBody =
          Image.memory(Uint8List.fromList(fullBodyres.bytes));
      return (
        username: username,
        uuid: uuid,
        cape: null,
        frontBody: fullBody,
        profile: profile,
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
  Profile? profile,
  List<Name> nameHistory,
  Image frontBody,
  Image? cape,
  MinersAvatarApiResponse minersAvatar
});
