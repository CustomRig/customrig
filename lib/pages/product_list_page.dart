import 'package:customrig/model/item.dart';
import 'package:customrig/providers/product_list/product_list_provider.dart';
import 'package:customrig/widgets/global_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String value;
  final bool isSearch;
  const ProductListPage({
    Key? key,
    required this.value,
    this.isSearch = false,
  }) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.isSearch) {
        Provider.of<ProductListProvider>(context, listen: false)
            .searchItems(widget.value);
      } else {
        Provider.of<ProductListProvider>(context, listen: false)
            .getItemsByCategory(widget.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return Consumer<ProductListProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.value.toLowerCase()),
          ),
          body: _buildGridView(
            screenDimension: screenDimension,
            provider: value,
          ),
        );
      },
    );
  }

  Widget _buildGridView({
    required Size screenDimension,
    required ProductListProvider provider,
  }) {
    // complete
    if (provider.state == ProductListState.complete) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:
              screenDimension.width / (screenDimension.height / 1.44),
        ),
        itemCount: provider.items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: MainProductCard(
              item: provider.items[index],
            ),
          );
        },
      );
    }

    // loading
    else if (provider.state == ProductListState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // error
    else if (provider.state == ProductListState.error) {
      return const Center(child: Text('Something went wrong!'));
    }

    // else
    else {
      return const Center(child: Text('Something went wrong!'));
    }
  }
}
