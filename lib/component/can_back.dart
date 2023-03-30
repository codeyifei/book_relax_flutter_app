import 'package:flutter/material.dart';

class WillBack extends StatelessWidget {
  final bool canBack;
  final Widget child;

  const WillBack({
    Key? key,
    required this.canBack,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (canBack) {
      return child;
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: child,
    );
  }
}
