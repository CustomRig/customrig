import 'package:customrig/model/all_items.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository_impl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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

  // Brand
  String? _processorBrand;
  String? get processorBrand => _processorBrand;

  String? _motherboardBrand;
  String? get motherboardBrand => _motherboardBrand;

  String? _graphicCardBrand;
  String? get graphicCardBrand => _graphicCardBrand;

  String? _powerSupplyBrand;
  String? get powerSupplyBrand => _powerSupplyBrand;

  String? _storageBrand;
  String? get storageBrand => _storageBrand;

  String? _ramBrand;
  String? get ramBrand => _ramBrand;

  String? _coolerBrand;
  String? get coolerBrand => _coolerBrand;

  String? _wifiBrand;
  String? get wifiAdapterBrand => _wifiBrand;

  String? _operatingSystemBrand;
  String? get operatingSystemBrand => _operatingSystemBrand;

  void setUsageType(String usageType) {
    _usageType = usageType;
    notifyListeners();
  }

  void setCabinet(Item item) {
    _cabinet = item;
    notifyListeners();
  }

  void setBrand({required String brand, required String category}) {
    switch (category) {
      case 'PROCESSOR':
        _processorBrand = brand;
        break;
      case 'MOTHERBOARD':
        _motherboardBrand = brand;
        break;
      case 'GRAPHIC_CARD':
        _graphicCardBrand = brand;
        break;
      case 'POWER_SUPPLY':
        _powerSupplyBrand = brand;
        break;
      case 'STORAGE':
        _storageBrand = brand;
        break;
      case 'RAM':
        _ramBrand = brand;
        break;
      case 'COOLER':
        _coolerBrand = brand;
        break;
      case 'WIFI_ADAPTER ':
        _wifiBrand = brand;
        break;
      case 'OPERATING_SYSTEM':
        _operatingSystemBrand = brand;
        break;
    }
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
      case 'WIFI_ADAPTER':
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
