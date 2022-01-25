import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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