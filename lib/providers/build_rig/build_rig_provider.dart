import 'package:customrig/model/all_items.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository_impl.dart';
import 'package:flutter/material.dart';

enum BuildRigState {
  initial,
  loading,
  complete,
  error,
}

class BuildRigProvider extends ChangeNotifier {
  BuildRigState _state = BuildRigState.initial;
  BuildRigState get state => _state;

  final BuildRigRepository _repository = BuildRigRepositoryImpl();

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

  AllItems? allItems;

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

  void getAllItems() async {
    setState(BuildRigState.loading);
    try {
      final items = await _repository.getAllItems();
      print(items.cabinet!.brands![0]);
      allItems = items;
      setState(BuildRigState.complete);
    } on Exception catch (e) {
      setState(BuildRigState.error);
      print(e.toString());
    }

    notifyListeners();
  }

  void setState(BuildRigState state) {
    _state = state;
    notifyListeners();
  }
}
