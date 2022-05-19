import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 100);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late ThemeData themeData;
  late TextEditingController _controller;
  static final ValueNotifier<String> searchValueNotifier = ValueNotifier('');
  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    _controller = TextEditingController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _controller,
            onChanged: (value) {
              searchValueNotifier.value = _controller.text;
            },
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
}
