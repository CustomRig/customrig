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

enum BuildRigFinishState {
  initial,
  loading,
  complete,
  error,
}

class BuildRigProvider extends ChangeNotifier {
  BuildRigState _state = BuildRigState.initial;
  BuildRigState get state => _state;

  BuildRigFinishState _finishState = BuildRigFinishState.initial;
  BuildRigFinishState get finishState => _finishState;

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
        if (_processorBrand == brand) {
          _processorBrand = null;
        } else {
          _processorBrand = brand;
        }
        break;

      case 'MOTHERBOARD':
        if (_motherboardBrand == brand) {
          _motherboardBrand = null;
        } else {
          _motherboardBrand = brand;
        }
        break;

      case 'GRAPHIC_CARD':
        if (_graphicCardBrand == brand) {
          _graphicCardBrand = null;
        } else {
          _graphicCardBrand = brand;
        }
        break;

      case 'POWER_SUPPLY':
        if (_powerSupplyBrand == brand) {
          _powerSupplyBrand = null;
        } else {
          _powerSupplyBrand = brand;
        }
        break;

      case 'STORAGE':
        if (_storageBrand == brand) {
          _storageBrand = null;
        } else {
          _storageBrand = brand;
        }
        break;

      case 'RAM':
        if (_ramBrand == brand) {
          _ramBrand = null;
        } else {
          _ramBrand = brand;
        }
        break;

      case 'COOLER':
        if (_coolerBrand == brand) {
          _coolerBrand = null;
        } else {
          _coolerBrand = brand;
        }
        break;

      case 'WIFI_ADAPTER':
        if (_wifiBrand == brand) {
          _wifiBrand = null;
        } else {
          _wifiBrand = brand;
        }
        break;

      case 'OPERATING_SYSTEM':
        if (_operatingSystemBrand == brand) {
          _operatingSystemBrand = null;
        } else {
          _operatingSystemBrand = brand;
        }
        break;
    }
    notifyListeners();
  }

  void setItem({required Item item, required String category}) {
    switch (category) {
      case 'PROCESSOR':
        if (_processor?.id == item.id) {
          _processor = null;
        } else {
          _processor = item;
        }
        break;

      case 'MOTHERBOARD':
        if (_motherboard?.id == item.id) {
          _motherboard = null;
        } else {
          _motherboard = item;
        }
        break;

      case 'GRAPHIC_CARD':
        if (_graphicCard?.id == item.id) {
          _graphicCard = null;
        } else {
          _graphicCard = item;
        }
        break;

      case 'POWER_SUPPLY':
        if (_powerSupply?.id == item.id) {
          _powerSupply = null;
        } else {
          _powerSupply = item;
        }
        break;

      case 'STORAGE':
        if (_storage?.id == item.id) {
          _storage = null;
        } else {
          _storage = item;
        }
        break;

      case 'RAM':
        if (_ram?.id == item.id) {
          _ram = null;
        } else {
          _ram = item;
        }
        break;

      case 'COOLER':
        if (_cooler?.id == item.id) {
          _cooler = null;
        } else {
          _cooler = item;
        }
        break;

      case 'WIFI_ADAPTER':
        if (_wifi?.id == item.id) {
          _wifi = null;
        } else {
          _wifi = item;
        }
        break;

      case 'OPERATING_SYSTEM':
        if (_operatingSystem?.id == item.id) {
          _operatingSystem = null;
        } else {
          _operatingSystem = item;
        }
        break;
    }
    notifyListeners();
  }

  int _getRigPrice() {
    int cabinetPrice = _cabinet?.price ?? 0;
    int processorPrice = _processor?.price ?? 0;
    int motherboardPrice = _motherboard?.price ?? 0;
    int graphicCardPrice = _graphicCard?.price ?? 0;
    int powerSupplyPrice = _powerSupply?.price ?? 0;
    int storagePrice = _storage?.price ?? 0;
    int ramPrice = _ram?.price ?? 0;
    int coolerPrice = _cooler?.price ?? 0;
    int wifiPrice = _wifi?.price ?? 0;
    int operatingSystemPrice = _operatingSystem?.price ?? 0;

    return cabinetPrice +
        processorPrice +
        motherboardPrice +
        graphicCardPrice +
        powerSupplyPrice +
        storagePrice +
        ramPrice +
        coolerPrice +
        wifiPrice +
        operatingSystemPrice;
  }

  String _getRigDescription() {
    return '${_processor!.title!}  ${_ram!.title!} Ram,  ${_graphicCard?.title ?? 'NO'} GPU';
  }

  String _getRigTitle() {
    return '${_usageType.toLowerCase()} rig';
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

  Future<Rig?> buildUserRig() async {
    Rig? rig;
    setFinishState(BuildRigFinishState.loading);
    try {
      rig = await _repository.buildUserRig(
        title: _getRigTitle(),
        description: _getRigDescription(),
        price: _getRigPrice(),
        usage: [_usageType],
        cabinetId: _cabinet?.id,
        processorId: _processor?.id,
        motherboardId: _motherboard?.id,
        graphicCardId: graphicCard?.id,
        powerSupplyId: powerSupply?.id,
        storageId: storage?.id,
        ramId: ram?.id,
        coolerId: _cooler?.id,
        wifiAdapterId: wifiAdapter?.id,
        operatingSystemId: operatingSystem?.id,
      );
      setFinishState(BuildRigFinishState.complete);
      return rig;
    } on DioError catch (e) {
      setFinishState(BuildRigFinishState.error);
      return null;
    }
  }

  void setState(BuildRigState state) {
    _state = state;
    notifyListeners();
  }

  void setFinishState(BuildRigFinishState state) {
    _finishState = state;
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
