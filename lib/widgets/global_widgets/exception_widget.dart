import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';

class ExceptionWidget extends StatefulWidget {
  const ExceptionWidget({Key? key}) : super(key: key);

  @override
  State<ExceptionWidget> createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> {
  bool isInternet = true;

  Future<void> _isInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty) {
        setState(() {
          isInternet = true;
        });
      } else {
        setState(() {
          isInternet = false;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isInternet = false;
      });
    }
  }

  @override
  void initState() {
    _isInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          EvaIcons.alertTriangleOutline,
          size: 28,
        ),
        Text(
          isInternet ? 'Something went wrong!' : 'No internet connection!',
          style: MyTextStyles.productTitle,
        ),
        Text(
          isInternet
              ? 'Please try again later.'
              : 'Please connect to internet.',
          style: MyTextStyles.productSubtitle,
        ),
      ],
    ));
  }
}
