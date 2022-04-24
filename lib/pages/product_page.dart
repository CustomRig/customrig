import 'package:customrig/model/base_item.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
import 'package:customrig/widgets/global_widgets/rig_items_table.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final BaseItem item;
  const ProductPage({Key? key, required this.item}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Size screenDimension;

  final ScrollController _scrollController = ScrollController();
  bool isAtBottom = false;
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    screenDimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(EvaIcons.heartOutline),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
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
          _buildItemImage(url: widget.item.imageUrl ?? ''),
          _buildItemTitleAndDescription(widget.item),
          if (widget.item.type == 'RIG') RigItemTable(widget.item),
        ],
      ),
      bottomSheet: _buildBottomSheet(isAtBottom),
    );
  }

  Widget _buildBottomSheet(bool isAtBottom) {
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
                      widget.item.type == 'RIG' ? 'TOTAL PRICE' : 'PRICE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    MyBadge(
                      text: '₹ ' + formatCurrency(widget.item.price ?? 0),
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
        if (widget.item.type == 'ITEM')
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
