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

  List<String>? pairingIds;
  List<String>? usage;

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

  BaseItem();

  BaseItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    brand = json['brand'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];

    if (json['type'] == 'RIG') {
      imageUrl = json['cabinet']['image_url'];
    } else {
      imageUrl = json['image_url'];
    }

    purchaseUrl = json['purchaseUrl'];

    if (json['pairingIds'] != null) {
      pairingIds = json['pairingIds'].cast<String>();
    }

    if (json['usage'] != null) {
      usage = json['usage'].cast<String>();
    }

    if (json['cabinet'] != null) {
      cabinet = Item.fromJson(json['cabinet']);
    }

    if (json['processor'] != null) {
      processor = Item.fromJson(json['processor']);
    }

    if (json['motherboard'] != null) {
      motherboard = Item.fromJson(json['motherboard']);
    }

    if (json['graphic_card'] != null) {
      graphicCard = Item.fromJson(json['graphic_card']);
    }

    if (json['power_supply'] != null) {
      powerSupply = Item.fromJson(json['power_supply']);
    }

    if (json['storage'] != null) {
      storage = Item.fromJson(json['storage']);
    }

    if (json['ram'] != null) {
      ram = Item.fromJson(json['ram']);
    }

    if (json['cooler'] != null) {
      cooler = Item.fromJson(json['cooler']);
    }

    if (json['wifi_adapter'] != null) {
      wifiAdapter = Item.fromJson(json['wifi_adapter']);
    }

    if (json['operating_system'] != null) {
      operatingSystem = Item.fromJson(json['operating_system']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['type'] = type;
    data['brand'] = brand;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['image_url'] = imageUrl;
    data['purchase_url'] = purchaseUrl;
    data['pairing_ids'] = pairingIds;
    data['usage'] = usage;
    data['cabinet'] = cabinet;
    data['processor'] = processor;
    data['motherboard'] = motherboard;
    data['graphic_card'] = graphicCard;
    data['power_supply'] = powerSupply;
    data['storage'] = storage;
    data['ram'] = ram;
    data['cooler'] = cooler;
    data['wifi_adapter'] = wifiAdapter;
    data['operating_system'] = operatingSystem;

    return data;
  }
}
