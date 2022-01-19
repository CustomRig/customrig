import 'package:customrig/pages/build_rig_pages/select_cabinet.dart';
import 'package:customrig/pages/build_rig_pages/select_items.dart';
import 'package:customrig/pages/build_rig_pages/select_usage.dart';
import 'package:customrig/providers/build_rig_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildRigMainPage extends StatefulWidget {
  const BuildRigMainPage({Key? key}) : super(key: key);

  @override
  _BuildRigMainPageState createState() => _BuildRigMainPageState();
}

class _BuildRigMainPageState extends State<BuildRigMainPage>
    with TickerProviderStateMixin {
  int totalSteps = 11; // total 11 to build rig
  int currentStep = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BuildRigProvider(),
      child: Consumer<BuildRigProvider>(
        builder: (context, buildRigProvider, child) {
          return DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Custom Build'),
                bottom: PreferredSize(
                  child: LinearProgressIndicator(value: currentStep / 10),
                  preferredSize: const Size.fromHeight(6.0),
                ),
              ),
              //
              body: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  SelectUsage(
                    selectedUsage: buildRigProvider.usageType,
                    onSelectedUsageChanged: (usage) =>
                        buildRigProvider.setUsageType(usage),
                  ),
                  SelectCabinet(
                    selectedCabinet: buildRigProvider.cabinet,
                    onSelectedCabinetChanged: (cabinet) =>
                        buildRigProvider.setCabinet(cabinet),
                  ),
                  SelectItems(
                    itemName: 'ram',
                    items: [],
                  )
                ],
              ),
              //
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _tabController.animateTo(_tabController.index++);
                  setState(() {
                    currentStep = _tabController.index;
                  });
                },
                child: const Icon(EvaIcons.chevronRight),
              ),
            ),
          );
        },
      ),
    );
  }
}
