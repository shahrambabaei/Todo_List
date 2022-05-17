import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:todo_list/data.dart';

class BodyListView extends StatefulWidget {
  const BodyListView({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<BodyListView> createState() => _BodyListViewState();
}

class _BodyListViewState extends State<BodyListView> {
  late ThemeData themeData;
  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        enableFeedback: false,
        onTap: () {},
        child: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
          ),
          child: Row(children: [
            buildCheckBox(
                isActived: widget.task.isCompeleted,
                onClick: () {
                  setState(() {
                    widget.task.isCompeleted = !widget.task.isCompeleted;
                  });
                }),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              widget.task.text,
              style: TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  decoration: widget.task.isCompeleted
                      ? TextDecoration.lineThrough
                      : null),
            ))
          ]),
        ),
      ),
    );
  }

  Widget buildCheckBox({required bool isActived, required Function() onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  !isActived ? Border.all(color: Colors.grey, width: 2) : null,
              color: isActived ? themeData.colorScheme.primary : null),
          child: isActived
              ? Icon(
                  Icons.check,
                  color: themeData.colorScheme.onPrimary,
                  size: 18,
                )
              : null),
    );
  }
}
