import 'package:flutter/material.dart';

class FloatingActionButtonWidgets extends StatelessWidget {
  const FloatingActionButtonWidgets({Key? key, required this.icon})
      : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(.2)),
      child: Icon(
        icon,
        size: 18,
      ),
    );
  }
}
