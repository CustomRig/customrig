import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BuildRigMainPage extends StatefulWidget {
  const BuildRigMainPage({Key? key}) : super(key: key);

  @override
  _BuildRigMainPageState createState() => _BuildRigMainPageState();
}

class _BuildRigMainPageState extends State<BuildRigMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Build'),
        bottom: const PreferredSize(
          child: LinearProgressIndicator(value: 2 / 10),
          preferredSize: Size.fromHeight(6.0),
        ),
      ),

      //

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(EvaIcons.chevronRight),
      ),
    );
  }
}
