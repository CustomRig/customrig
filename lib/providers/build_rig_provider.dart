import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';
import 'package:flutter/material.dart';

class BuildRigProvider extends ChangeNotifier {
  Rig newRig = Rig();

  String usageType = '';
  String cabinet = '';
  Item? processor;
  Item? motherboard;
  Item? graphicCard;
  Item? powerSupply;
  Item? storage;
  Item? ram;
  Item? cooler;
  Item? wifi;
  Item? operatingSystem;

  void setUsageType(String usageType) {
    this.usageType = usageType;
    notifyListeners();
  }

  void setCabinet(String cabinet) {
    this.cabinet = cabinet;
    notifyListeners();
  }

  void setItem({required Item item, required String type}) {
    switch (type) {
      case 'PROCESSOR':
        processor = item;
        break;
      case 'MOTHERBOARD':
        motherboard = item;
        break;
      case 'GRAPHIC_CARD':
        graphicCard = item;
        break;
      case 'POWER_SUPPLY':
        powerSupply = item;
        break;
      case 'STORAGE':
        storage = item;
        break;
      case 'RAM':
        ram = item;
        break;
      case 'COOLER':
        cooler = item;
        break;
      case 'WIFI':
        wifi = item;
        break;
      case 'OPERATING_SYSTEM':
        operatingSystem = item;
        break;
    }
    notifyListeners();
  }
}