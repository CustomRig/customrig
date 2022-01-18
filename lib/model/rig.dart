class Rig {
  String? title;
  String? description;
  String? cabinet;
  String? processor;
  String? motherboard;
  String? graphicCard;
  String? powerSupply;
  String? storage;
  String? ram;
  String? cooler;
  String? wifiAdapter;
  String? operatingSystem;
  String? type;

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
  });

  Rig.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    cabinet = json['cabinet'];
    processor = json['processor'];
    motherboard = json['motherboard'];
    graphicCard = json['graphic_card'];
    powerSupply = json['power_supply'];
    storage = json['storage'];
    ram = json['ram'];
    cooler = json['cooler'];
    wifiAdapter = json['wifi_adapter'];
    operatingSystem = json['operating_system'];
    type = json['type'];
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
    return data;
  }
}
