import 'package:customrig/model/base_item.dart';
import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
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
          _scrollController.position.maxScrollExtent - 40) {
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
          _buildItemTitleAndDescription(
            title: widget.item.title ?? '',
            description: widget.item.description ?? '',
          ),
          if (widget.item.type == 'RIG') RigItemTable(widget.item),
        ],
      ),
      bottomSheet: _buildBottomSheet(isAtBottom),
    );
  }

  Widget _buildBottomSheet(bool isAtBottom) {
    return !isAtBottom
        ? Padding(
            padding: const EdgeInsets.all(12.0),
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
                      'TOTAL PRICE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    MyBadge(
                      text: widget.item.price.toString(),
                      secondary: true,
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

  Widget _buildItemTitleAndDescription(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(height: 8.0),
        Text(title, style: MyTextStyles.productTitle),
        Text(description, style: MyTextStyles.productSubtitle),
        spacer(height: 8.0),
      ],
    );
  }
}
