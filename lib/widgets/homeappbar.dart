import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double width, height;
  const HomeAppBar({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: 102,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        themeData.colorScheme.primary,
        themeData.colorScheme.primaryContainer
      ])),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('To Do List',
                style: themeData.textTheme.headline6!
                    .apply(color: themeData.colorScheme.onPrimary)),
            Icon(
              Icons.menu,
              color: themeData.colorScheme.onPrimary,
            )
          ],
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(top: 15),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(Icons.search, color: secondaryTextColor),
                hintText: 'search tasks...',
                hintStyle: const TextStyle(color: secondaryTextColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white),
          ),
        )
      ]),
    );
  }

  @override
  Size get preferredSize => Size(width, height);
}
