import 'package:customrig/providers/product_list/product_list_provider.dart';
import 'package:customrig/widgets/global_widgets/main_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final String value;
  final String? type;
  final bool isSearch;
  const ProductListPage({
    Key? key,
    required this.value,
    this.isSearch = false,
    this.type,
    required this.title,
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
            .getItemsByCategory(category: widget.value, type: widget.type!);
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
          appBar: !widget.isSearch ? AppBar(title: Text(widget.title)) : null,
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
      if (provider.items.isNotEmpty) {
        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                screenDimension.width / (screenDimension.width * 1.15),
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
      } else {
        return const Center(
          child: Text('Nothing to show!'),
        );
      }
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
