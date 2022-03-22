import 'package:customrig/model/base_item.dart';
import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
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
          if (widget.item.type == 'RIG') _buildRigItemsTable(widget.item),
          if (widget.item.type == 'ITEM') _buildItemPrice(widget.item),
        ],
      ),
      bottomSheet: !isAtBottom
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8.0),
                color: kBlueAccentColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL PRICE',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
          : SizedBox.shrink(),
    );
  }

  Widget _buildItemPrice(BaseItem item) {
    return Container();
  }

  Widget _buildRigItemsTable(BaseItem item) {
    return DataTable(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 3,
          ),
        ],
      ),
      columns: const [
        DataColumn(label: Text('ITEM')),
        DataColumn(numeric: true, label: Text('PRICE (₹)')),
      ],
      rows: [
        // The actual items
        DataRow(
          cells: [
            DataCell(Text(item.motherboard?.title ?? '')),
            DataCell(MyBadge(text: item.motherboard?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.processor?.title ?? '')),
            DataCell(MyBadge(text: item.processor?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.ram?.title ?? '')),
            DataCell(MyBadge(text: item.ram?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.storage?.title ?? '')),
            DataCell(MyBadge(text: item.storage?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.powerSupply?.title ?? '')),
            DataCell(MyBadge(text: item.powerSupply?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.wifiAdapter?.title ?? '')),
            DataCell(MyBadge(text: item.wifiAdapter?.price.toString() ?? '')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text(item.operatingSystem?.title ?? '')),
            DataCell(
                MyBadge(text: item.operatingSystem?.price.toString() ?? '')),
          ],
        ),

        // Total price Row
        DataRow(
          selected: true,
          cells: [
            const DataCell(
              Text(
                'TOTAL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              MyBadge(text: item.price.toString(), secondary: true),
            ),
          ],
        ),
      ],
    );
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
