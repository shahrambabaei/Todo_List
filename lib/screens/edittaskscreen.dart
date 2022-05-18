import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/data.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/widgets/floatingactionbuttonwidgets.dart';
import 'package:todo_list/widgets/prioritycheckbox.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _controller;
  final box = Hive.box<Task>(taskBoxName);
  late ThemeData themeData;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.task.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        elevation: 0,
        title: const Text('Edit task'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      child: PriorityCheckBox(
                    lable: 'High',
                    color: highPriority,
                    isSelected: widget.task.priority == Priority.high,
                    onClick: () {
                      setState(() {
                        widget.task.priority = Priority.high;
                      });
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: PriorityCheckBox(
                    lable: 'Normal',
                    color: normalPriority,
                    isSelected: widget.task.priority == Priority.normal,
                    onClick: () {
                      setState(() {
                        widget.task.priority = Priority.normal;
                      });
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: PriorityCheckBox(
                    lable: 'Low',
                    color: lowPriority,
                    isSelected: widget.task.priority == Priority.low,
                    onClick: () {
                      setState(() {
                        widget.task.priority = Priority.low;
                      });
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              //TextField
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    hintText: 'Add a task for today...',
                    border: InputBorder.none),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            widget.task.text = _controller.text;
            widget.task.isCompeleted = false;
            widget.task.priority = widget.task.priority;
            if (widget.task.isInBox) {
             widget. task.save();
            } else {
              box.add( widget.task);
            }
            Navigator.pop(context);
          },
          label: Row(
            children: const [
              Text('SaveChange'),
              SizedBox(
                width: 10,
              ),
              FloatingActionButtonWidgets(icon: Icons.check_outlined)
            ],
          )),
    );
  }
}
