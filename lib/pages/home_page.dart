import 'package:customrig/widgets/global_widgets/my_horizontal_list.dart';
import 'package:customrig/widgets/home_page_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // call dashboard api here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(3.0),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildTitle('Top Gaming Builds'),
          _buildTopGamingBuildCategory(),
          //
          _buildTitle('Top Budget Builds'),
          _buildTopBudgetBuildCategory()
        ],
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
        // style: MyTextStyles.title,
      ),
    );
  }
}
