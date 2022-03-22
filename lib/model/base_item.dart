import 'package:customrig/model/item.dart';

class BaseItem {
  String? id;
  String? type;
  String? brand;
  String? title;
  String? description;
  String? category;
  int? price;

  String? imageUrl;
  String? purchaseUrl;

  List<int>? pairingIds;

  Item? cabinet;
  Item? processor;
  Item? motherboard;
  Item? graphicCard;
  Item? powerSupply;
  Item? storage;
  Item? ram;
  Item? cooler;
  Item? wifiAdapter;
  Item? operatingSystem;
}
