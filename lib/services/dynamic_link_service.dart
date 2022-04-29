import 'package:customrig/pages/product_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  Future<String> createDynamicLink(String itemId, String type) async {
    final _dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://customrig.page.link/product?id=$itemId&type=$type"),
      uriPrefix: "https://customrig.page.link",
      androidParameters:
          const AndroidParameters(packageName: "me.varad.customrig"),
      iosParameters: const IOSParameters(bundleId: "me.varad.customrig"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(_dynamicLinkParams);

    return dynamicLink.toString();
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final deepLink = dynamicLinkData.link;
      print(deepLink);
      String? id = deepLink.queryParameters["id"];
      String? type = deepLink.queryParameters["type"];
      print(id);
      if (id != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductPage(item: null, itemId: id, type: type),
          ),
        );
      }
    });
  }
}
