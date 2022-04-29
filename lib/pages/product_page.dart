import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/product_page/product_page_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
import 'package:customrig/widgets/global_widgets/rig_items_table.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final BaseItem? item;
  final String? itemId;
  final String? type;
  const ProductPage({Key? key, this.item, this.itemId, this.type})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Size screenDimension;

  final ScrollController _scrollController = ScrollController();
  bool isAtBottom = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<ProductPageProvider>(context, listen: false).loadProduct(
        widget.item,
        itemId: widget.itemId,
        type: widget.type,
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.offset >
              _scrollController.position.maxScrollExtent - 40 &&
          _scrollController.hasClients) {
        setState(() {
          isAtBottom = true;
        });
      } else {
        setState(() {
          isAtBottom = false;
        });
      }
    });
    super.initState();
  }

  // void _checkIfFavorite() async {
  //   final provider = Provider.of<ProductPageProvider>(context, listen: false);
  //   isFavorite = await provider.isFavorite(product!.id!);
  //   setState(() {
  //     isFavorite = isFavorite;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    screenDimension = MediaQuery.of(context).size;
    return Consumer<ProductPageProvider>(
      builder: (context, value, child) {
        // loading product from API
        if (value.state == ProductPageState.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // if loaded from local product object or Dynamic link
        else if (value.state == ProductPageState.complete) {
          if (value.product != null) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  // TODO: make able to add rigs to favorites
                  value.product?.type == 'ITEM'
                      ? IconButton(
                          icon: Icon(
                            value.isFavorite
                                ? EvaIcons.heart
                                : EvaIcons.heartOutline,
                            color: value.isFavorite ? Colors.redAccent : null,
                          ),
                          onPressed: () => value.handleFavorite(),
                        )
                      : const SizedBox.shrink(),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () async {
                      await value.shareProduct(value.product!);
                    },
                  ),
                  IconButton(
                    icon: const Icon(EvaIcons.download),
                    onPressed: () {},
                  ),
                ],
              ),
              body: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12.0),
                children: [
                  _buildItemImage(url: value.product?.imageUrl ?? ''),
                  _buildItemTitleAndDescription(value.product!),
                  if (value.product?.type == 'RIG')
                    RigItemTable(value.product!),
                ],
              ),
              bottomSheet: _buildBottomSheet(value.product!, isAtBottom),
            );
          } else {
            return Text('something went wrong lol');
          }
        }

        // if api fetch fails
        else if (value.state == ProductPageState.error) {
          return const Text('Failed to load item');
        }

        // if all above fails
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildBottomSheet(BaseItem product, bool isAtBottom) {
    return !isAtBottom
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.type == 'RIG' ? 'TOTAL PRICE' : 'PRICE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    MyBadge(
                      text: '₹ ' + formatCurrency(product.price ?? 0),
                    )
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildItemImage({required String url}) {
    return Container(
      width: double.maxFinite,
      height: screenDimension.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildItemTitleAndDescription(BaseItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(height: 8.0),
        if (item.brand != null)
          Text(item.brand ?? '', style: Theme.of(context).textTheme.caption),
        //
        Text(
          item.title ?? '',
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        spacer(height: 8.0),
        if (item.type == 'ITEM')
          ElevatedButton.icon(
            onPressed: () {
              launchURL(item.purchaseUrl ?? '');
            },
            icon: const Icon(EvaIcons.shoppingBagOutline),
            label: const Text('BUY NOW'),
          ),

        spacer(height: 8.0),
        Text("Product Description", style: Theme.of(context).textTheme.caption),
        Text(item.description ?? '',
            style: Theme.of(context).textTheme.bodyText1),
        spacer(height: 8.0),
      ],
    );
  }
}
