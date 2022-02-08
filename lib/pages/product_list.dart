import 'package:customrig/widgets/global_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('category Title here'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:
              screenDimension.width / (screenDimension.height / 1.42),
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.all(2.0),
            child: MainProductCard(
              title: 'fffff',
              price: 1212,
              imageUrl: 'fafaf',
            ),
          );
        },
      ),
    );
  }
}
