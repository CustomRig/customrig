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
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: true,
                    sliver: SliverAppBar(
                      title: Text('Custom Rig'),
                      leading: Icon(Icons.menu),
                      bottom: PreferredSize(
                        child: _searchBar(),
                        preferredSize: Size.fromHeight(56),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body:

                // if (dashboardProvider.state == DashboardState.complete &&
                // dashboardProvider.dashboard!.sections!.isNotEmpty)
                ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: dashboardProvider.dashboard!.sections!.map((e) {
                return Column(
                  children: [
                    _buildTitle(e.title ?? ''),
                    _buildItems(e.items ?? [], type: e.type ?? 'RIG'),
                  ],
                );
              }).toList(),
            ),

            // if (dashboardProvider.state == DashboardState.loading)
            //   //TODO: replace with shimmer
            //   const CircularProgressIndicator(),

            // if (dashboardProvider.state == DashboardState.error)
            //   const Center(child: Text('Something went wrong')),

            // if (dashboardProvider.state == DashboardState.complete &&
            //     dashboardProvider.dashboard!.sections!.isEmpty)
            //   const Center(
            //     child: Text('Looks like there is nothing to show'),
            //   ),
          ),
          floatingActionButton: isListScrolling
              ? _smallFloatingActionButton(context)
              : _expandedFloatingActionButton(context),
        );
      },
    );
  }

  Padding _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: kBlueAccentColor,
          hintText: "Search 'Gaming keyboard'",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.red,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  AnimatedContainer _expandedFloatingActionButton(BuildContext context) {
    return AnimatedContainer(
      height: 70,
      width: 150,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
      child: FloatingActionButton.extended(
        onPressed: () => goToPage(context, const BuildRigMainPage()),
        icon: const Icon(Icons.handyman_outlined),
        label: const Text('Build Rig'),
      ),
    );
  }

  AnimatedContainer _smallFloatingActionButton(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () => goToPage(context, const BuildRigMainPage()),
        child: const Icon(Icons.handyman_outlined),
      ),
    );
  }

  Widget _buildItems(List<dynamic> items, {required String type}) {
    if (type == 'RIG') {
      return MyHorizontalList(
        items: items
            .map((e) => MainProductCard(
                  title: e.title,
                  price: e.price,
                  imageUrl: e.cabinet.imageUrl,
                ))
            .toList(),
      );
    } else {
      return MyHorizontalList(
        items: items
            .map((e) => MainProductCard(
                  title: e.title,
                  price: e.price,
                  imageUrl: e.imageUrl,
                ))
            .toList(),
      );
    }
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
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
