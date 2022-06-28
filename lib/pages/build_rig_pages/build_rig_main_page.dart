import 'package:customrig/pages/build_rig_pages/select_cabinet.dart';
import 'package:customrig/pages/build_rig_pages/select_items.dart';
import 'package:customrig/pages/build_rig_pages/select_usage.dart';
import 'package:customrig/pages/product_page.dart';
import 'package:customrig/providers/build_rig/build_rig_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/dialogs/item_details_dialog.dart';
import 'package:customrig/widgets/global_widgets/exception_widget.dart';
import 'package:customrig/widgets/global_widgets/my_circular_progress_indicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

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

  List list = [];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 11);
    _listenToTabController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BuildRigProvider>(context, listen: false).getAllItems();
    });

    super.initState();
  }

  void _listenToTabController() {
    _tabController.addListener(() {
      setState(() {
        currentStep = _tabController.index;
      });
    });
  }

  void _goNext() {
    _tabController.animateTo(
      _tabController.index != _tabController.length - 1
          ? ++_tabController.index
          : _tabController.index,
    );
  }

  void _goTo(int index) {
    _tabController.animateTo(index);
  }

  void _handleNextButton(BuildRigProvider provider) {
    // usageType
    if (_tabController.index == 0) {
      if (provider.usageType != '') {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select usage');
      }
    }

    // cabinet
    else if (_tabController.index == 1) {
      if (provider.cabinet != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Cabinet');
      }
    }

    // processor
    else if (_tabController.index == 2) {
      // print(provider.processor?.pairingIds?.first);
      if (provider.processor != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Processor');
      }
    }

// motherboard
    else if (_tabController.index == 3) {
      if (provider.motherboard != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Motherboard');
      }
    }

    // ram
    else if (_tabController.index == 4) {
      if (provider.ram != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select RAM');
      }
    }

    // storage
    else if (_tabController.index == 5) {
      if (provider.storage != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Storage');
      }
    }

    // gpu
    else if (_tabController.index == 6) {
      if (provider.usageType == 'OFFICE' ||
          provider.usageType == 'SCHOOL' ||
          provider.graphicCard != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Graphic Card');
      }
    }

    // cooler
    else if (_tabController.index == 7) {
      if (provider.cooler != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Cooler');
      }
    }

    //power supply
    else if (_tabController.index == 8) {
      if (provider.powerSupply != null) {
        _goNext();
      } else {
        showMySnackBar(context, text: 'Please select Power Supply');
      }
    } else {
      _goNext();
    }
  }

  void _handleFinishButton(BuildRigProvider provider) async {
    if (provider.usageType == '') {
      showMySnackBar(context, text: 'Please select usage');
      _goTo(0);
    } else if (provider.cabinet == null) {
      showMySnackBar(context, text: 'Please select cabinet');
      _goTo(1);
    } else if (provider.processor == null) {
      showMySnackBar(context, text: 'Please select processor');
      _goTo(2);
    } else if (provider.motherboard == null) {
      showMySnackBar(context, text: 'Please select Motherboard');
      _goTo(3);
    } else if (provider.ram == null) {
      showMySnackBar(context, text: 'Please select Ram');
      _goTo(4);
    } else if (provider.graphicCard == null && provider.usageType == 'GAMING') {
      showMySnackBar(context, text: 'Please select Graphic Card');
      _goTo(6);
    } else if (provider.cooler == null) {
      showMySnackBar(context, text: 'Please select Cooler');
      _goTo(7);
    } else if (provider.powerSupply == null) {
      showMySnackBar(context, text: 'Please select Power supply');
      _goTo(8);
    } else {
      final rig = await provider.buildUserRig();
      if (rig != null) {
        replacePage(context, ProductPage(item: rig));
      } else {
        showMySnackBar(context, text: 'Failed to create rig!');
      }
    }
  }

  Future<bool?> _confirmExit() async {
    if (currentStep > 1) {
      return showMyDialog<bool>(
          context,
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text('Exit custom build?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop<bool>(context, false);
                  },
                  child: const Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('EXIT')),
            ],
          ));
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _confirmExit();
        return result ?? false;
      },
      child: Consumer<BuildRigProvider>(
        builder: (context, provider, child) {
          return ShowCaseWidget(
            builder: Builder(builder: (context) {
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
                              usage: provider.usageType,
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
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "PROCESSOR"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              category: provider.allItems!.processor!.category!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // mother board
                            SelectItems(
                              itemName:
                                  provider.allItems!.motherboard!.category!,
                              brands: provider.allItems!.motherboard!.brands!,
                              items: provider.allItems!.motherboard!.items!,
                              selectedBrand: provider.motherboardBrand,
                              selectedItem: provider.motherboard,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "MOTHERBOARD"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "MOTHERBOARD"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              category:
                                  provider.allItems!.motherboard!.category!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // RAM
                            SelectItems(
                              category: provider.allItems!.ram!.category!,
                              itemName: provider.allItems!.ram!.category!,
                              brands: provider.allItems!.ram!.brands!,
                              items: provider.allItems!.ram!.items!,
                              selectedBrand: provider.ramBrand,
                              selectedItem: provider.ram,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "RAM"),
                              onItemChanged: (item) =>
                                  provider.setItem(item: item, category: "RAM"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // Storage
                            SelectItems(
                              category: provider.allItems!.storage!.category!,
                              itemName: provider.allItems!.storage!.category!,
                              brands: provider.allItems!.storage!.brands!,
                              items: provider.allItems!.storage!.items!,
                              selectedBrand: provider.storageBrand,
                              selectedItem: provider.storage,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "STORAGE"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "STORAGE"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            //graphic card
                            SelectItems(
                              category:
                                  provider.allItems!.graphicCard!.category!,
                              itemName:
                                  provider.allItems!.graphicCard!.category!,
                              brands: provider.allItems!.graphicCard!.brands!,
                              items: provider.allItems!.graphicCard!.items!,
                              selectedBrand: provider.graphicCardBrand,
                              selectedItem: provider.graphicCard,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "GRAPHIC_CARD"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "GRAPHIC_CARD"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // cooler
                            SelectItems(
                              category: provider.allItems!.cooler!.category!,
                              itemName: provider.allItems!.cooler!.category!,
                              brands: provider.allItems!.cooler!.brands!,
                              items: provider.allItems!.cooler!.items!,
                              selectedBrand: provider.coolerBrand,
                              selectedItem: provider.cooler,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "COOLER"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "COOLER"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // power supply
                            SelectItems(
                              category:
                                  provider.allItems!.powerSupply!.category!,
                              itemName:
                                  provider.allItems!.powerSupply!.category!,
                              brands: provider.allItems!.powerSupply!.brands!,
                              items: provider.allItems!.powerSupply!.items!,
                              selectedBrand: provider.powerSupplyBrand,
                              selectedItem: provider.powerSupply,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "POWER_SUPPLY"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "POWER_SUPPLY"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // wifi adapter
                            SelectItems(
                              category:
                                  provider.allItems!.wifiAdapter!.category!,
                              itemName:
                                  provider.allItems!.wifiAdapter!.category!,
                              brands: provider.allItems!.wifiAdapter!.brands!,
                              items: provider.allItems!.wifiAdapter!.items!,
                              selectedBrand: provider.wifiAdapterBrand,
                              selectedItem: provider.wifiAdapter,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "WIFI_ADAPTER"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "WIFI_ADAPTER"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),

                            // OS
                            SelectItems(
                              category:
                                  provider.allItems!.operatingSystem!.category!,
                              itemName:
                                  provider.allItems!.operatingSystem!.category!,
                              brands:
                                  provider.allItems!.operatingSystem!.brands!,
                              items: provider.allItems!.operatingSystem!.items!,
                              selectedBrand: provider.operatingSystemBrand,
                              selectedItem: provider.operatingSystem,
                              onBrandChanged: (brand) => provider.setBrand(
                                  brand: brand, category: "OPERATING_SYSTEM"),
                              onItemChanged: (item) => provider.setItem(
                                  item: item, category: "OPERATING_SYSTEM"),
                              usage: provider.usageType,
                              pairingIds: provider.processor?.pairingIds!,
                              showItemDetails: (item) {
                                showMyDialog(context, ItemDetailsDialog(item));
                              },
                            ),
                          ],
                        )
                      : provider.state == BuildRigState.loading
                          ? _showLoadingWidget()
                          : provider.state == BuildRigState.error
                              ? const ExceptionWidget()
                              : const ExceptionWidget(),
                  //

                  floatingActionButton: provider.state == BuildRigState.complete
                      ? _getFloatingActionButton(provider)
                      : const SizedBox.shrink(),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _getFloatingActionButton(BuildRigProvider provider) {
    if (_tabController.index != _tabController.length - 1) {
      return FloatingActionButton(
        onPressed: () {
          _handleNextButton(provider);
        },
        child: const Icon(EvaIcons.chevronRight),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () async {
          _handleFinishButton(provider);
        },
        label: const Text('FINISH'),
        icon: provider.finishState == BuildRigFinishState.loading
            ? const MyCircularProgressIndicator()
            : const Icon(EvaIcons.checkmark),
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
}
