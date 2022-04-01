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

  String _usageType = '';
  String get usageType => _usageType;

  Item? _cabinet;
  Item? get cabinet => _cabinet;

  Item? _processor;
  Item? get processor => _processor;

  Item? _motherboard;
  Item? get motherboard => _motherboard;

  Item? _graphicCard;
  Item? get graphicCard => _graphicCard;

  Item? _powerSupply;
  Item? get powerSupply => _powerSupply;

  Item? _storage;
  Item? get storage => _storage;

  Item? _ram;
  Item? get ram => _ram;

  Item? _cooler;
  Item? get cooler => _cooler;

  Item? _wifi;
  Item? get wifiAdapter => _wifi;

  Item? _operatingSystem;
  Item? get operatingSystem => _operatingSystem;

  AllItems? _allItems;
  AllItems? get allItems => _allItems;

  String? _processorBrand;
  String? get brand => _processorBrand;

  void setProcessorBrand(String brand) {
    _processorBrand = brand;
    notifyListeners();
  }

  void setUsageType(String usageType) {
    _usageType = usageType;
    notifyListeners();
  }

  void setCabinet(Item cabinet) {
    _cabinet = cabinet;
    notifyListeners();
  }

  void setProcessor(Item processor) {
    _processor = processor;
    notifyListeners();
  }

  void setItem({required Item item, required String category}) {
    switch (category) {
      case 'PROCESSOR':
        _processor = item;
        break;
      case 'MOTHERBOARD':
        _motherboard = item;
        break;
      case 'GRAPHIC_CARD':
        _graphicCard = item;
        break;
      case 'POWER_SUPPLY':
        _powerSupply = item;
        break;
      case 'STORAGE':
        _storage = item;
        break;
      case 'RAM':
        _ram = item;
        break;
      case 'COOLER':
        _cooler = item;
        break;
      case 'WIFI':
        _wifi = item;
        break;
      case 'OPERATING_SYSTEM':
        _operatingSystem = item;
        break;
    }
    notifyListeners();
  }

  void getAllItems() async {
    setState(BuildRigState.loading);
    try {
      final items = await _repository.getAllItems();
      // print(items.cabinet!.brands![0]);
      _allItems = items;
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
