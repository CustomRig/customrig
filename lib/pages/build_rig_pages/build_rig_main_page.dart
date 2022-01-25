import 'package:customrig/pages/build_rig_pages/select_cabinet.dart';
import 'package:customrig/pages/build_rig_pages/select_items.dart';
import 'package:customrig/pages/build_rig_pages/select_usage.dart';
import 'package:customrig/providers/build_rig/build_rig_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<BuildRigProvider>(context, listen: false).getAllItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuildRigProvider>(
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
            body: buildRigProvider.state == BuildRigState.complete
                ? TabBarView(
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
                  )
                : buildRigProvider.state == BuildRigState.loading
                    ? _showLoadingWidget()
                    : buildRigProvider.state == BuildRigState.error
                        ? _showErrorWidget()
                        : const SizedBox.shrink(),
            //

            floatingActionButton:
                buildRigProvider.state == BuildRigState.complete
                    ? FloatingActionButton(
                        onPressed: () {
                          _tabController.animateTo(_tabController.index++);
                          setState(() {
                            currentStep = _tabController.index;
                          });
                        },
                        child: const Icon(EvaIcons.chevronRight),
                      )
                    : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _showLoadingWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          spacer(height: 12),
          const Text(
            'Please Wait',
            style: MyTextStyles.productTitle,
          ),
          const Text(
            'Searching the best pc parts for you!',
            style: MyTextStyles.productSubtitle,
          ),
        ],
      ),
    );
  }

  Widget _showErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            EvaIcons.alertTriangleOutline,
            size: 28,
          ),
          Text(
            'Something went wrong!',
            style: MyTextStyles.productTitle,
          ),
          Text(
            'Please try again later.',
            style: MyTextStyles.productSubtitle,
          ),
        ],
      ),
    );
  }
}
