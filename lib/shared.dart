import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const int mcinfo_build_version = 1;

typedef MinersAvatarApiResponse = ({
  Image? flatAvatar,
  Image? helmAvatar,
  Image? isometricAvatar,
  Image? flatFrontBody,
  Image? helmFrontBody,
  Image? flatBust,
  Image? helmBust,
  Image? userSkin,
});

final class MinersAvatarApi {
  MinersAvatarApi._();

  static const String baseUrl = "minotar.net";
  static const String flatAvatar = "$baseUrl/avatar";
  static const String helmAvatar = "$baseUrl/helm";
  static const String isometricAvatar = "$baseUrl/cube";
  static const String flatFrontBody = "$baseUrl/body";
  static const String helmFrontBody = "$baseUrl/armor/body";
  static const String flatBust = "$baseUrl/bust";
  static const String helmBust = "$baseUrl/armor/bust";
  static const String userSkin = "$baseUrl/skin";

  static String _urlFormalizer(String username) => "/$username.png";

  static Future<MinersAvatarApiResponse> fetch(
      String username) async {
    print("fetching items from miners-avatar-api...");
    http.Response flatAvatarRes = await http
        .get(Uri.https(flatAvatar + _urlFormalizer(username)));
    http.Response helmAvatarRes = await http
        .get(Uri.https(helmAvatar + _urlFormalizer(username)));
    http.Response isometricAvatarRes = await http
        .get(Uri.https(isometricAvatar + _urlFormalizer(username)));
    http.Response flatFrontBodyRes = await http
        .get(Uri.https(flatFrontBody + _urlFormalizer(username)));
    http.Response helmFrontBodyRes = await http
        .get(Uri.https(helmFrontBody + _urlFormalizer(username)));
    http.Response flatBustRes = await http
        .get(Uri.https(flatBust + _urlFormalizer(username)));
    http.Response helmBustRes = await http
        .get(Uri.https(helmBust + _urlFormalizer(username)));
    http.Response userSkinRes = await http
        .get(Uri.https(userSkin + _urlFormalizer(username)));
    print("returning payload for miners-avatar-api!");
    return (
      flatAvatar: flatFrontBodyRes.statusCode == 200
          ? Image.memory(Uint8List.fromList(flatAvatarRes.bodyBytes))
          : null,
      helmAvatar: helmAvatarRes.statusCode == 200
          ? Image.memory(Uint8List.fromList(helmAvatarRes.bodyBytes))
          : null,
      isometricAvatar: isometricAvatarRes.statusCode == 200
          ? Image.memory(
              Uint8List.fromList(isometricAvatarRes.bodyBytes))
          : null,
      flatFrontBody: flatFrontBodyRes.statusCode == 200
          ? Image.memory(
              Uint8List.fromList(flatFrontBodyRes.bodyBytes))
          : null,
      helmFrontBody: helmFrontBodyRes.statusCode == 200
          ? Image.memory(
              Uint8List.fromList(helmFrontBodyRes.bodyBytes))
          : null,
      flatBust: flatBustRes.statusCode == 200
          ? Image.memory(Uint8List.fromList(flatBustRes.bodyBytes))
          : null,
      helmBust: helmBustRes.statusCode == 200
          ? Image.memory(Uint8List.fromList(helmBustRes.bodyBytes))
          : null,
      userSkin: userSkinRes.statusCode == 200
          ? Image.memory(Uint8List.fromList(userSkinRes.bodyBytes))
          : null,
    );
  }
}
