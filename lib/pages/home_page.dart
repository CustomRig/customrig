import 'package:customrig/model/product.dart';
import 'package:customrig/pages/build_rig_pages/build_rig_main_page.dart';
import 'package:customrig/pages/product_list.dart';
import 'package:customrig/providers/dashboard/dashboard_provider.dart';
import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/my_horizontal_list.dart';
import 'package:customrig/widgets/global_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool isListScrolling = false;

  int fakedashboardLength = 4;

  late Size screenSize;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<DashboardProvider>(context, listen: false).getDashboard();
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        setState(() {
          isListScrolling = true;
        });
      } else {
        setState(() {
          isListScrolling = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, child) {
        if (dashboardProvider.state == DashboardState.complete) {
          print('COMPLETE');
        }
        return Scaffold(
          body: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kBlueAccentColor,
                    hintText: "Search 'Gaming keyboard' ",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: dashboardProvider.dashboard!.sections!.map((e) {
                  return Column(
                    children: [
                      _buildTitle(e.title!),
                      _buildItems(e.items!),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
          floatingActionButton: isListScrolling
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear,
                  height: 70,
                  width: 70,
                  child: FloatingActionButton(
                    onPressed: () =>
                        goToPage(context, const BuildRigMainPage()),
                    child: const Icon(Icons.handyman_outlined),
                  ),
                )
              : AnimatedContainer(
                  height: 70,
                  width: 150,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear,
                  child: FloatingActionButton.extended(
                    onPressed: () =>
                        goToPage(context, const BuildRigMainPage()),
                    icon: const Icon(Icons.handyman_outlined),
                    label: const Text('Build Rig'),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildItems(List<Product> items) {
  
    return MyHorizontalList(
      items: items.map((e) => MainProductCard(title: e., price: price, imageUrl: imageUrl))
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * .7,
            child: Text(
              title,
              style: MyTextStyles.heading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => goToPage(context, const ProductList()),
            child: const Text('VIEW MORE'),
          )
        ],
      ),
    );
  }
}
