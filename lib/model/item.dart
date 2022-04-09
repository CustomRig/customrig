import 'package:customrig/model/base_item.dart';

class Item extends BaseItem {
  Item();
  Item.fromJson(Map<String, dynamic> json) {
    super.brand = json['brand'];
    super.title = json['title'];
    super.description = json['description'];
    super.price = json['price'];
    super.imageUrl = json['image_url'];
    super.purchaseUrl = json['purchase_url'];
    super.pairingIds = json['pairing_ids'].cast<String>();
    super.type = json['type'];
    super.category = json['category'];
    super.id = json['_id'];
    super.usage = json['usage'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = super.brand;
    data['title'] = super.title;
    data['description'] = super.description;
    data['price'] = super.price;
    data['image_url'] = super.imageUrl;
    data['purchase_url'] = super.purchaseUrl;
    data['pairing_ids'] = super.pairingIds;
    data['type'] = super.type;
    data['category'] = super.type;
    data['id'] = super.id;
    return data;
  }
}
