import 'package:customrig/providers/user_build/user_build_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/widgets/global_widgets/small_product_card.dart';
import 'package:customrig/widgets/shimmer_widgets/small_card_page_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyRigsPage extends StatefulWidget {
  const MyRigsPage({Key? key}) : super(key: key);

  @override
  _MyRigsPageState createState() => _MyRigsPageState();
}

class _MyRigsPageState extends State<MyRigsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserBuildProvider>(context, listen: false).getUserBuild();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBuildProvider>(builder: (context, value, child) {
      return Scaffold(body: _buildUserBuildRigs(value));
    });
  }

  Widget _buildUserBuildRigs(UserBuildProvider value) {
    // loading
    if (value.state == UserBuildState.loading ||
        value.state == UserBuildState.initial) {
      return const SmallCardPageShimmer();
    }

    // complete
    else if (value.state == UserBuildState.complete) {
      if (value.userBuilds.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/empty_cart.svg',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              spacer(height: 12),
              const Text(
                'No builds yet!',
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
          children: value.userBuilds
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
    }

    // error
    else if (value.state == UserBuildState.error) {
      return Text(value.errorMessage);
    }

    // else
    else {
      return const Text('Something went wrong!');
    }
  }
}
