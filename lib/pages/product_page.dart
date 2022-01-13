import 'package:customrig/utils/colors.dart';
import 'package:customrig/utils/dummy_data.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/text_styles.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Size screenDimension;
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        children: [
          _buildItemImage(url: kDummyProductImage),
          _buildItemTitleAndDescription(
              title: kDummyTitle, description: kDummyDescription),

          // Data table here

          DataTable(
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
              const DataRow(
                cells: [
                  DataCell(Text('Item 1')),
                  DataCell(MyBadge(text: '77272772')),
                ],
              ),
              const DataRow(
                cells: [
                  DataCell(Text('Item 1')),
                  DataCell(MyBadge(text: '77272772')),
                ],
              ),
              DataRow(
                color: MaterialStateProperty.all(Colors.grey.shade100),
                selected: true,
                cells: const [
                  DataCell(Text('TOTAL')),
                  DataCell(MyBadge(
                    text: '77272772',
                    secondary: true,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
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
