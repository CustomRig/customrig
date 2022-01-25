import 'package:customrig/model/item.dart';

class AllItems {
  Part? cabinet;
  Part? processor;
  Part? motherboard;
  Part? graphicCard;
  Part? powerSupply;
  Part? storage;
  Part? ram;
  Part? cooler;
  Part? wifiAdapter;
  Part? operatingSystem;

  AllItems({
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
  });

  AllItems.fromJson(Map<String, dynamic> json) {
    cabinet = json['cabinet'] != null ? Part.fromJson(json['cabinet']) : null;
    processor =
        json['processor'] != null ? Part.fromJson(json['processor']) : null;
    motherboard =
        json['motherboard'] != null ? Part.fromJson(json['motherboard']) : null;
    graphicCard = json['graphic_card'] != null
        ? Part.fromJson(json['graphic_card'])
        : null;
    powerSupply = json['power_supply'] != null
        ? Part.fromJson(json['power_supply'])
        : null;
    storage = json['storage'] != null ? Part.fromJson(json['storage']) : null;
    ram = json['ram'] != null ? Part.fromJson(json['ram']) : null;
    cooler = json['cooler'] != null ? Part.fromJson(json['cooler']) : null;
    wifiAdapter = json['wifi_adapter'] != null
        ? Part.fromJson(json['wifi_adapter'])
        : null;
    operatingSystem = json['operating_system'] != null
        ? Part.fromJson(json['operating_system'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cabinet != null) {
      data['cabinet'] = cabinet!.toJson();
    }
    if (processor != null) {
      data['processor'] = processor!.toJson();
    }
    if (motherboard != null) {
      data['motherboard'] = motherboard!.toJson();
    }
    if (graphicCard != null) {
      data['graphic_card'] = graphicCard!.toJson();
    }
    if (powerSupply != null) {
      data['power_supply'] = powerSupply!.toJson();
    }
    if (storage != null) {
      data['storage'] = storage!.toJson();
    }
    if (ram != null) {
      data['ram'] = ram!.toJson();
    }
    if (cooler != null) {
      data['cooler'] = cooler!.toJson();
    }
    if (wifiAdapter != null) {
      data['wifi_adapter'] = wifiAdapter!.toJson();
    }
    if (operatingSystem != null) {
      data['operating_system'] = operatingSystem!.toJson();
    }
    return data;
  }
}

class Part {
  List<String>? brands;
  List<Item>? items;
  String? type;

  Part({this.brands, this.items, this.type});

  Part.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = [];
      json['brands'].forEach((v) {
        brands!.add(v);
      });
    }
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brands != null) {
      data['brands'] = brands!.map((v) => v).toList();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    return data;
  }
}
