import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class PriorityCheckBox extends StatelessWidget {
  const PriorityCheckBox(
      {Key? key,
      required this.lable,
      required this.color,
      required this.isSelected,
      required this.onClick})
      : super(key: key);
  final String lable;
  final Color color;
  final bool isSelected;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: secondaryTextColor.withOpacity(.2), width: 2)),
        child: Stack(children: [
          Center(
            child: Text(lable),
          ),
          Positioned(
              right: 5,
              bottom: 0,
              top: 0,
              child: Center(
                child: itemCheckBox(color: color, isActived: isSelected),
              ))
        ]),
      ),
    );
  }

  Widget itemCheckBox({required Color color, required bool isActived}) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child:
          isActived ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
    );
  }
}
