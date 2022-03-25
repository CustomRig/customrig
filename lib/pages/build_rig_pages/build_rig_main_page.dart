import 'package:customrig/pages/build_rig_pages/select_cabinet.dart';
import 'package:customrig/pages/build_rig_pages/select_items.dart';
import 'package:customrig/pages/build_rig_pages/select_usage.dart';
import 'package:customrig/providers/build_rig/build_rig_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
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
    _tabController = TabController(vsync: this, length: 11);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<BuildRigProvider>(context, listen: false).getAllItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuildRigProvider>(
      builder: (context, provider, child) {
        return DefaultTabController(
          length: 11,
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
            body: provider.state == BuildRigState.complete
                ? TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // usage
                      SelectUsage(
                        selectedUsage: provider.usageType,
                        onSelectedUsageChanged: (usage) =>
                            provider.setUsageType(usage),
                      ),

                      // Cabinet
                      SelectCabinet(
                        cabinets: provider.allItems!.cabinet!.items!,
                        selectedCabinet: provider.cabinet,
                        onSelectedCabinetChanged: (cabinet) =>
                            provider.setCabinet(cabinet),
                      ),

                      // processor
                      SelectItems(
                        itemName: provider.allItems!.processor!.category!,
                        brands: provider.allItems!.processor!.brands!,
                        items: provider.allItems!.processor!.items!,
                        selectedBrand: provider.processor!.brand!,
                        selectedItem: provider.processor!,
                      ),

                      // mother board
                      SelectItems(
                        itemName: provider.allItems!.motherboard!.category!,
                        brands: provider.allItems!.motherboard!.brands!,
                        items: provider.allItems!.motherboard!.items!,
                        selectedBrand: provider.motherboard!.brand!,
                        selectedItem: provider.motherboard!,
                      ),

                      // RAM
                      SelectItems(
                        itemName: provider.allItems!.ram!.category!,
                        brands: provider.allItems!.ram!.brands!,
                        items: provider.allItems!.ram!.items!,
                        selectedBrand: provider.ram!.brand!,
                        selectedItem: provider.ram!,
                      ),

                      // Storage
                      SelectItems(
                        itemName: provider.allItems!.storage!.category!,
                        brands: provider.allItems!.storage!.brands!,
                        items: provider.allItems!.storage!.items!,
                        selectedBrand: provider.storage!.brand!,
                        selectedItem: provider.storage!,
                      ),

                      //graphic card
                      SelectItems(
                        itemName: provider.allItems!.graphicCard!.category!,
                        brands: provider.allItems!.graphicCard!.brands!,
                        items: provider.allItems!.graphicCard!.items!,
                        selectedBrand: provider.graphicCard!.brand!,
                        selectedItem: provider.graphicCard!,
                      ),

                      // cooler
                      SelectItems(
                        itemName: provider.allItems!.cooler!.category!,
                        brands: provider.allItems!.cooler!.brands!,
                        items: provider.allItems!.cooler!.items!,
                        selectedBrand: provider.cooler!.brand!,
                        selectedItem: provider.cooler!,
                      ),

                      // power supply
                      SelectItems(
                        itemName: provider.allItems!.powerSupply!.category!,
                        brands: provider.allItems!.powerSupply!.brands!,
                        items: provider.allItems!.powerSupply!.items!,
                        selectedBrand: provider.powerSupply!.brand!,
                        selectedItem: provider.powerSupply!,
                      ),

                      // wifi adapter
                      SelectItems(
                        itemName: provider.allItems!.wifiAdapter!.category!,
                        brands: provider.allItems!.wifiAdapter!.brands!,
                        items: provider.allItems!.wifiAdapter!.items!,
                        selectedBrand: provider.wifiAdapter!.brand!,
                        selectedItem: provider.wifiAdapter!,
                      ),

                      // OS
                      SelectItems(
                        itemName: provider.allItems!.operatingSystem!.category!,
                        brands: provider.allItems!.operatingSystem!.brands!,
                        items: provider.allItems!.operatingSystem!.items!,
                        selectedBrand: provider.operatingSystem!.brand!,
                        selectedItem: provider.operatingSystem!,
                      ),
                    ],
                  )
                : provider.state == BuildRigState.loading
                    ? _showLoadingWidget()
                    : provider.state == BuildRigState.error
                        ? _showErrorWidget()
                        : const SizedBox.shrink(),
            //

            floatingActionButton: provider.state == BuildRigState.complete
                ? FloatingActionButton(
                    onPressed: () {
                      _tabController.animateTo(++_tabController.index);
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
