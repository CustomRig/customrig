import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';

class Dashboard {
  int? limit;
  List<Section>? sections;
  Dashboard({this.sections});

  Dashboard.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    if (json['sections'] != null) {
      sections = <Section>[];
      json['sections'].forEach((v) {
        sections!.add(Section.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Section {
  String? title;
  List<BaseItem>? items;
  String? type;

  Section({this.title, this.items, this.type});

  Section.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];

    if (json['type'] == 'RIG') {
      if (json['items'] != null) {
        items = <Rig>[];
        json['items'].forEach((v) {
          items!.add(Rig.fromJson(v));
        });
      }
    } else {
      if (json['items'] != null) {
        items = <Item>[];
        json['items'].forEach((v) {
          items!.add(Item.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError('toJson not implemented for class BaseItem');

    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (items != null) {
      // data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
