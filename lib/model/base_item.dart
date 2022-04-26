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
