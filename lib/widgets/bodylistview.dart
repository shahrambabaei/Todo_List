import 'package:flutter/material.dart';
import 'package:todo_list/data.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/screens/edittaskscreen.dart';

class BodyListView extends StatefulWidget {
  const BodyListView({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<BodyListView> createState() => _BodyListViewState();
}

class _BodyListViewState extends State<BodyListView> {
  late ThemeData themeData;
  late Color priorityColor;
  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = lowPriority;
        break;
      case Priority.normal:
        priorityColor = normalPriority;
        break;
      case Priority.high:
        priorityColor = highPriority;
        break;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        // enableFeedback: false,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: widget.task),
              ));
        },
        onLongPress: (){
          widget.task.delete();
        },
        child: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 12),
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
            )),
            Container(
              width: 7,
              height: 70,
              decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
            )
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
