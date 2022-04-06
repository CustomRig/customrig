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

  IconData _fabIcon = EvaIcons.chevronRight;

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
                        selectedBrand: provider.processorBrand,
                        selectedItem: provider.processor,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "PROCESSOR"),
                        onItemChanged: (item) =>
                            provider.setItem(item: item, category: "PROCESSOR"),
                      ),

                      // mother board
                      SelectItems(
                        itemName: provider.allItems!.motherboard!.category!,
                        brands: provider.allItems!.motherboard!.brands!,
                        items: provider.allItems!.motherboard!.items!,
                        selectedBrand: provider.motherboardBrand,
                        selectedItem: provider.motherboard,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "MOTHERBOARD"),
                        onItemChanged: (item) => provider.setItem(
                            item: item, category: "MOTHERBOARD"),
                      ),

                      // RAM
                      SelectItems(
                        itemName: provider.allItems!.ram!.category!,
                        brands: provider.allItems!.ram!.brands!,
                        items: provider.allItems!.ram!.items!,
                        selectedBrand: provider.ramBrand,
                        selectedItem: provider.ram,
                        onBrandChanged: (brand) =>
                            provider.setBrand(brand: brand, category: "RAM"),
                        onItemChanged: (item) =>
                            provider.setItem(item: item, category: "RAM"),
                      ),

                      // Storage
                      SelectItems(
                        itemName: provider.allItems!.storage!.category!,
                        brands: provider.allItems!.storage!.brands!,
                        items: provider.allItems!.storage!.items!,
                        selectedBrand: provider.storageBrand,
                        selectedItem: provider.storage,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "STORAGE"),
                        onItemChanged: (item) =>
                            provider.setItem(item: item, category: "STORAGE"),
                      ),

                      //graphic card
                      SelectItems(
                        itemName: provider.allItems!.graphicCard!.category!,
                        brands: provider.allItems!.graphicCard!.brands!,
                        items: provider.allItems!.graphicCard!.items!,
                        selectedBrand: provider.graphicCardBrand,
                        selectedItem: provider.graphicCard,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "GRAPHIC_CARD"),
                        onItemChanged: (item) => provider.setItem(
                            item: item, category: "GRAPHIC_CARD"),
                      ),

                      // cooler
                      SelectItems(
                        itemName: provider.allItems!.cooler!.category!,
                        brands: provider.allItems!.cooler!.brands!,
                        items: provider.allItems!.cooler!.items!,
                        selectedBrand: provider.coolerBrand,
                        selectedItem: provider.cooler,
                        onBrandChanged: (brand) =>
                            provider.setBrand(brand: brand, category: "COOLER"),
                        onItemChanged: (item) =>
                            provider.setItem(item: item, category: "COOLER"),
                      ),

                      // power supply
                      SelectItems(
                        itemName: provider.allItems!.powerSupply!.category!,
                        brands: provider.allItems!.powerSupply!.brands!,
                        items: provider.allItems!.powerSupply!.items!,
                        selectedBrand: provider.powerSupplyBrand,
                        selectedItem: provider.powerSupply,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "POWER_SUPPLY"),
                        onItemChanged: (item) => provider.setItem(
                            item: item, category: "POWER_SUPPLY"),
                      ),

                      // wifi adapter
                      SelectItems(
                        itemName: provider.allItems!.wifiAdapter!.category!,
                        brands: provider.allItems!.wifiAdapter!.brands!,
                        items: provider.allItems!.wifiAdapter!.items!,
                        selectedBrand: provider.wifiAdapterBrand,
                        selectedItem: provider.wifiAdapter,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "WIFI_ADAPTER"),
                        onItemChanged: (item) => provider.setItem(
                            item: item, category: "WIFI_ADAPTER"),
                      ),

                      // OS
                      SelectItems(
                        itemName: provider.allItems!.operatingSystem!.category!,
                        brands: provider.allItems!.operatingSystem!.brands!,
                        items: provider.allItems!.operatingSystem!.items!,
                        selectedBrand: provider.operatingSystemBrand,
                        selectedItem: provider.operatingSystem,
                        onBrandChanged: (brand) => provider.setBrand(
                            brand: brand, category: "OPERATING_SYSTEM"),
                        onItemChanged: (item) => provider.setItem(
                            item: item, category: "OPERATING_SYSTEM"),
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
                ? _getFloatingActionButton()
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _getFloatingActionButton() {
    if (_tabController.index != _tabController.length - 1) {
      return FloatingActionButton(
        onPressed: () {
          _tabController.animateTo(
            _tabController.index != _tabController.length - 1
                ? ++_tabController.index
                : _tabController.index,
          );
        },
        child: const Icon(EvaIcons.chevronRight),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('FINISH'),
        icon: const Icon(EvaIcons.checkmark),
      );
    }
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
