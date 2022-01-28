import 'package:customrig/model/item.dart';

class Rig {
  String? title;
  String? description;
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
  String? type;
  String? category;

  Rig({
    this.title,
    this.description,
    this.cabinet,
    this.processor,
    this.motherboard,
    this.graphicCard,
    this.powerSupply,
    this.storage,
    this.ram,
    this.cooler,
    this.wifiAdapter,
    this.operatingSystem,
    this.type,
    this.category,
  });

  Rig.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
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

    type = json['type'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
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
    data['type'] = type;
    data['category'] = category;
    return data;
  }
}
