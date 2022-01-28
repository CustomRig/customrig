class Item {
  String? brand;
  String? title;
  String? description;
  int? price;
  String? imageUrl;
  String? purchaseUrl;
  List<int>? pairingIds;
  String? type;
  String? category;
  String? id;

  Item({
    this.brand,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.purchaseUrl,
    this.pairingIds,
    this.type,
    this.category,
    this.id,
  });

  Item.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['image_url'];
    purchaseUrl = json['purchase_url'];
    pairingIds = json['pairing_ids'].cast<int>();
    type = json['type'];
    category = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['image_url'] = imageUrl;
    data['purchase_url'] = purchaseUrl;
    data['pairing_ids'] = pairingIds;
    data['type'] = type;
    data['category'] = type;
    data['id'] = id;
    return data;
  }
}
