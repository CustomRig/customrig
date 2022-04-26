import 'package:customrig/providers/user_build/user_build_provider.dart';
import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRigsPage extends StatefulWidget {
  const MyRigsPage({Key? key}) : super(key: key);

  @override
  _MyRigsPageState createState() => _MyRigsPageState();
}

class _MyRigsPageState extends State<MyRigsPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserBuildProvider>(context, listen: false).getUserBuild();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBuildProvider>(builder: (context, value, child) {
      return Scaffold(
        body: _buildUserBuildRigs(value),
      );
    });
  }

  Widget _buildUserBuildRigs(UserBuildProvider value) {
    if (value.state == UserBuildState.loading ||
        value.state == UserBuildState.initial) {
      return const Center(child: CircularProgressIndicator());
    } else if (value.state == UserBuildState.complete) {
      if (value.favoriteItems.isEmpty) {
        return const Center(child: Text('No Rigs yet'));
      } else {
        return ListView(
          padding: const EdgeInsets.all(12.0),
          physics: const BouncingScrollPhysics(),
          children: value.favoriteItems
              .map(
                (e) => SmallProductCard(
                  item: e,
                  onRemovePressed: () {
                    value.removeBuild(rigId: e.id!);
                  },
                ),
              )
              .toList(),
        );
      }
    } else if (value.state == UserBuildState.error) {
      return Text(value.errorMessage);
    } else {
      return const Text('Something went wrong!');
    }
  }
}
