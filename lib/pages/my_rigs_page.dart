import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:flutter/material.dart';

class MyRigsPage extends StatefulWidget {
  const MyRigsPage({Key? key}) : super(key: key);

  @override
  _MyRigsPageState createState() => _MyRigsPageState();
}

class _MyRigsPageState extends State<MyRigsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        physics: const BouncingScrollPhysics(),
        children: [
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
          SmallProductCard(),
        ],
      ),
    );
  }
}
