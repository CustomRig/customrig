import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/dashboard.dart';
import 'package:customrig/pages/build_rig_pages/build_rig_main_page.dart';
import 'package:customrig/pages/product_list_page.dart';
import 'package:customrig/providers/dashboard/dashboard_provider.dart';
import 'package:customrig/services/dynamic_link_service.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/my_horizontal_list.dart';
import 'package:customrig/widgets/global_widgets/main_product_widget.dart';
import 'package:customrig/widgets/shimmer_widgets/home_page_shimmer_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    DynamicLinkService.initDynamicLink(context);

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
      builder: (context, provider, child) {
        return Scaffold(
          body: _buildMainSection(provider: provider),
          floatingActionButton: isListScrolling
              ? _smallFloatingActionButton(context)
              : _expandedFloatingActionButton(context),
        );
      },
    );
  }

  Widget _buildMainSection({required DashboardProvider provider}) {
    // complete
    if (provider.state == DashboardState.complete &&
        provider.dashboard!.sections!.isNotEmpty) {
      return SmartRefresher(
        controller: provider.refreshController,
        onRefresh: () => provider.getDashboard(),
        child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: provider.dashboard!.sections!.map((e) {
            return Column(
              children: [
                _buildTitle(e),
                _buildItems(e.items ?? [], type: e.type ?? 'RIG'),
              ],
            );
          }).toList(),
        ),
      );
    }

    // loading
    else if (provider.state == DashboardState.loading) {
      return const HomePageShimmer();
    }

    // error
    else if (provider.state == DashboardState.error) {
      return _showErrorWidget();
    }

    // null
    else if (provider.dashboard == null) {
      return const Center(child: Text('Nothing to show'));
    }

    // something went wrong
    else {
      return const Center(child: Text('Something went wrong!'));
    }
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

  Widget _buildItems(List<BaseItem> items, {required String type}) {
    return MyHorizontalList(
      items: items.map((e) => MainProductCard(item: e)).toList(),
    );
  }

  Widget _buildTitle(Section section) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * .65,
            child: Text(
              section.title!,
              style: MyTextStyles.heading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => goToPage(
                context,
                ProductListPage(
                  value: section.category!,
                  type: section.type,
                  title: section.title!,
                )),
            child: const Text('VIEW MORE'),
          )
        ],
      ),
    );
  }
}
