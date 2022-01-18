import 'package:customrig/model/rig.dart';
import 'package:flutter/material.dart';

class BuildRigProvider extends ChangeNotifier {
  Rig newRig = Rig();

  String usageType = '';

  void setUsageType(String usageType) {
    this.usageType = usageType;
    notifyListeners();
  }
}
