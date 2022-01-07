import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/my_horizontal_list.dart';
import 'package:customrig/widgets/home_page_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool isListScrolling = false;

  @override
  void initState() {
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
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(12.0),
        physics: const BouncingScrollPhysics(),
        children: [
          TextFormField(
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
          _buildTitle('Top Gaming Builds'),
          _buildTopGamingBuildCategory(),
          //
          _buildTitle('Top Budget Builds'),
          _buildTopBudgetBuildCategory(),
          //
          _buildTitle('Top Budget Builds'),
          _buildTopBudgetBuildCategory(),
          //
          _buildTitle('Top Budget Builds'),
          _buildTopBudgetBuildCategory(),
        ],
      ),
      floatingActionButton: !isListScrolling
          ? AnimatedContainer(
              height: 70,
              width: 150,
              duration: const Duration(milliseconds: 150),
              curve: Curves.linear,
              child: FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.handyman_outlined),
                label: const Text('Build Rig'),
              ),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.linear,
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.handyman_outlined),
              ),
            ),
    );
  }

  Widget _buildTopGamingBuildCategory() {
    return const MyHorizontalList(
      items: [
        MainProductCard(),
        MainProductCard(),
        MainProductCard(),
      ],
    );
  }

  Widget _buildTopBudgetBuildCategory() {
    return const MyHorizontalList(
      items: [
        MainProductCard(),
        MainProductCard(),
        MainProductCard(),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: MyTextStyles.heading,
      ),
    );
  }
}
