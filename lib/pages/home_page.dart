import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/dashboard.dart';
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
      builder: (context, provider, child) {
        return Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text('Custom Rig'),
                  leading: const Icon(Icons.menu),
                  bottom: PreferredSize(
                    child: _searchBar(),
                    preferredSize: const Size.fromHeight(63),
                  ),
                ),
              ];
            },
            body: _buildMainSection(provider: provider),
          ),
          floatingActionButton: isListScrolling
              ? _smallFloatingActionButton(context)
              : _expandedFloatingActionButton(context),
        );
      },
    );
  }

  Widget _buildMainSection({required DashboardProvider provider}) {
    if (provider.state == DashboardState.complete &&
        provider.dashboard!.sections!.isNotEmpty) {
      return ListView(
        // controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: provider.dashboard!.sections!.map((e) {
          return Column(
            children: [
              _buildTitle(e.title ?? ''),
              _buildItems(e.items ?? [], type: e.type ?? 'RIG'),
            ],
          );
        }).toList(),
      );
    } else if (provider.state == DashboardState.loading) {
      // TODO: replace loading indicator with shimmer
      return const Center(child: CircularProgressIndicator());
    } else if (provider.state == DashboardState.error) {
      return Center(child: Text(provider.errorMessage!));
    } else if (provider.dashboard == null) {
      return const Center(child: Text('Nothing to show'));
    } else {
      return const Center(child: Text('Something went wrong!'));
    }
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          hintText: "Search 'Gaming keyboard'",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
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

  Widget _buildItems(List<BaseItem> items, {required String type}) {
    return MyHorizontalList(
      items: items.map((e) => MainProductCard(item: e)).toList(),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * .65,
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
