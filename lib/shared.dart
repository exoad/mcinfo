import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_requests/http_requests.dart';

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

  static const String baseUrl = "https://minotar.net";
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
    HttpResponse flatAvatarRes =
        await HttpRequests.get(flatAvatar + _urlFormalizer(username));
    HttpResponse helmAvatarRes =
        await HttpRequests.get(helmAvatar + _urlFormalizer(username));
    HttpResponse isometricAvatarRes = await HttpRequests.get(
        isometricAvatar + _urlFormalizer(username));
    HttpResponse flatFrontBodyRes = await HttpRequests.get(
        flatFrontBody + _urlFormalizer(username));
    HttpResponse helmFrontBodyRes = await HttpRequests.get(
        helmFrontBody + _urlFormalizer(username));
    HttpResponse flatBustRes =
        await HttpRequests.get(flatBust + _urlFormalizer(username));
    HttpResponse helmBustRes =
        await HttpRequests.get(helmBust + _urlFormalizer(username));
    HttpResponse userSkinRes =
        await HttpRequests.get(userSkin + _urlFormalizer(username));
    return (
      flatAvatar: flatFrontBodyRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(flatAvatarRes.bytes))
          : null,
      helmAvatar: helmAvatarRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(helmAvatarRes.bytes))
          : null,
      isometricAvatar: isometricAvatarRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(isometricAvatarRes.bytes))
          : null,
      flatFrontBody: flatFrontBodyRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(flatFrontBodyRes.bytes))
          : null,
      helmFrontBody: helmFrontBodyRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(helmFrontBodyRes.bytes))
          : null,
      flatBust: flatBustRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(flatBustRes.bytes))
          : null,
      helmBust: helmBustRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(helmBustRes.bytes))
          : null,
      userSkin: userSkinRes.statusCode == HttpStatus.ok
          ? Image.memory(Uint8List.fromList(userSkinRes.bytes))
          : null,
    );
  }
}
