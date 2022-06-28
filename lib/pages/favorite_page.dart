import 'package:customrig/providers/favorite_items/favorite_items_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/exception_widget.dart';
import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:customrig/widgets/shimmer_widgets/small_card_page_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    // loading
    if (value.state == FavoriteItemState.loading ||
        value.state == FavoriteItemState.initial) {
      return const SmallCardPageShimmer();
    }

    // Complete
    else if (value.state == FavoriteItemState.complete) {
      if (value.favoriteItems.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/not_found.svg',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              spacer(height: 12),
              const Text(
                'No favorites yet!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
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
    }

    // error
    else if (value.state == FavoriteItemState.error) {
      return const ExceptionWidget();
    }

    // else
    else {
      return const ExceptionWidget();
    }
  }
}
