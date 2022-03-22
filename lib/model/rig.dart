import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';

class Rig extends BaseItem {
  Rig();

  Rig.fromJson(Map<String, dynamic> json) {
    super.type = json['type'];
    super.title = json['title'];
    super.description = json['description'];
    super.price = json['price'];
    if (json['cabinet'] != null) {
      super.cabinet = Item.fromJson(json['cabinet']);
    }

    if (json['processor'] != null) {
      super.processor = Item.fromJson(json['processor']);
    }

    if (json['motherboard'] != null) {
      super.motherboard = Item.fromJson(json['motherboard']);
    }

    if (json['graphic_card'] != null) {
      super.graphicCard = Item.fromJson(json['graphic_card']);
    }

    if (json['power_supply'] != null) {
      super.powerSupply = Item.fromJson(json['power_supply']);
    }

    if (json['storage'] != null) {
      super.storage = Item.fromJson(json['storage']);
    }

    if (json['ram'] != null) {
      super.ram = Item.fromJson(json['ram']);
    }

    if (json['cooler'] != null) {
      super.cooler = Item.fromJson(json['cooler']);
    }

    if (json['wifi_adapter'] != null) {
      super.wifiAdapter = Item.fromJson(json['wifi_adapter']);
    }

    if (json['operating_system'] != null) {
      super.operatingSystem = Item.fromJson(json['operating_system']);
    }

    super.imageUrl = json['cabinet']['image_url'];
    super.category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['title'] = title;
    // data['description'] = description;
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
    data['price'] = price;
    return data;
  }
}
