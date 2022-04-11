import 'package:customrig/providers/favorite_items/favorite_items_provider.dart';
import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<FavoriteItemsProvider>(context, listen: false)
          .getFavoriteItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteItemsProvider>(builder: (context, value, child) {
      return Scaffold(
        body: _buildFavoriteItems(value),
      );
    });
  }

  Widget _buildFavoriteItems(FavoriteItemsProvider value) {
    if (value.state == FavoriteItemState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (value.state == FavoriteItemState.complete) {
      if (value.favoriteItems.isEmpty) {
        return const Center(child: Text('No Favorite items yet'));
      } else {
        return ListView(
          padding: const EdgeInsets.all(12.0),
          physics: const BouncingScrollPhysics(),
          children: value.favoriteItems
              .map(
                (e) => SmallProductCard(
                  item: e,
                  onRemovePressed: () {
                    value.removeItemFromFavorite(itemId: e.id!);
                  },
                ),
              )
              .toList(),
        );
      }
    } else if (value.state == FavoriteItemState.error) {
      return Text(value.errorMessage);
    } else {
      return const Text('Something went wrong!');
    }
  }
}
