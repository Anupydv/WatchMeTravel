import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_me_travel/providers/user_provider.dart';
import 'package:watch_me_travel/utils/dimentions.dart';

class Responsive extends StatefulWidget {
  final Widget webLayout;
  final Widget mobileLayout;
  const Responsive(
      {Key? key, required this.webLayout, required this.mobileLayout})
      : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webSizeScreen) {
          return widget.webLayout;
          // Web Screen
        }
        return widget.mobileLayout;
        //Mobile Screen
      },
    );
  }
}
