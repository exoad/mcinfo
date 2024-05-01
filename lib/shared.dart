import 'dart:io';

import 'package:http_requests/http_requests.dart';

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

  static Future<void> fetch(
      {required String url, required String username}) async {
    HttpResponse res =
        await HttpRequests.get(url + _urlFormalizer(username));
    if (res.statusCode == HttpStatus.ok) {
      print(res.contentType);
    } else {
      throw Exception("Failed to fetch avatar");
    }
  }
}
