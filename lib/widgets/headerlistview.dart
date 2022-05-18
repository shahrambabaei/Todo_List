import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data.dart';
import 'package:todo_list/main.dart';

class HeaderListView extends StatelessWidget {
  const HeaderListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final box = Hive.box<Task>(taskBoxName);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: themeData.textTheme.headline6!.apply(fontSizeFactor: .9),
            ),
            Container(
              height: 3,
              width: 70,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  color: themeData.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2)),
            )
          ],
        ),
        MaterialButton(
          color: const Color(0xFfEAEFF5),
          textColor: secondaryTextColor,
          elevation: 0,
          onPressed: () {
            box.clear();
          },
          child: Row(children: const [
            Text('Delete All'),
            SizedBox(
              width: 3,
            ),
            Icon(
              CupertinoIcons.delete_solid,
              size: 20,
            )
          ]),
        )
      ],
    );
  }
}
