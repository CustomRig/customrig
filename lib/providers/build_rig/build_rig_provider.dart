import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/all_items.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository.dart';
import 'package:customrig/providers/build_rig/repository/build_rig_repository_impl.dart';
import 'package:customrig/services/prefs.dart';
import 'package:dio/dio.dart';
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

  final Prefs _prefs = Prefs();

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
      case 'WIFI_ADAPTER':
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

  int _getRigPrice() {
    return cabinet!.price! +
        processor!.price! +
        motherboard!.price! +
        graphicCard!.price! +
        powerSupply!.price! +
        storage!.price! +
        ram!.price! +
        cooler!.price! +
        wifiAdapter!.price! +
        operatingSystem!.price!;
  }

  String _getRigDescription() {
    return '${_processor!.title!}  ${_ram!.title!} Ram,  ${_graphicCard!.title!} GPU';
  }

  String _getRigTitle() {
    return 'Rig #${UniqueKey().toString()}';
  }

  void getAllItems() async {
    if (_allItems == null) setState(BuildRigState.loading);

    try {
      final allItemsFromPrefs = await _getFavItemsFromPrefs();

      if (allItemsFromPrefs != null) {
        _allItems = allItemsFromPrefs;
        notifyListeners();
        setState(BuildRigState.complete);

        final allItemsFromApi = await _repository.getAllItems();

        if (allItemsFromApi != null) {
          _allItems = allItemsFromApi;
          notifyListeners();
        }
      } else {
        final items = await _repository.getAllItems();
        _prefs.setString(kBuildRigItems, json.encode(items));
        _allItems = items;
        setState(BuildRigState.complete);
      }
    } on DioError catch (e) {
      setState(BuildRigState.error);
    }

    notifyListeners();
  }

  Future<Rig> buildUserRig() async {
    Rig? rig;
    try {
      rig = await _repository.buildUserRig(
        title: _getRigTitle(),
        description: _getRigDescription(),
        price: _getRigPrice(),
        usage: _usageType,
        cabinetId: _cabinet?.id,
        processorId: _processor?.id,
        motherboardId: _motherboard?.id,
        graphicCardId: graphicCard?.id,
        powerSupplyId: powerSupply!.id,
        storageId: storage!.id,
        ramId: ram!.id,
        coolerId: _cooler!.id,
        wifiAdapterId: wifiAdapter!.id,
        operatingSystemId: operatingSystem!.id,
      );
    } on DioError catch (e) {}

    return rig!;
  }

  void setState(BuildRigState state) {
    _state = state;
    notifyListeners();
  }

  Future<AllItems?> _getFavItemsFromPrefs() async {
    final buildRigItemsPrefsString = await _prefs.getString(kBuildRigItems);
    if (buildRigItemsPrefsString != null) {
      final buildRigItemsFromPrefs = json.decode(buildRigItemsPrefsString);
      final buildRigItems = AllItems.fromJson(buildRigItemsFromPrefs);

      return buildRigItems;
    } else {
      return null;
    }
  }
}
