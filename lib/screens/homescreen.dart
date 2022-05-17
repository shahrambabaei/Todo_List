import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/screens/edittaskscreen.dart';
import 'package:todo_list/widgets/HeaderListView.dart';
import 'package:todo_list/widgets/bodylistview.dart';
import 'package:todo_list/widgets/floatingactionbuttonwidgets.dart';
import 'package:todo_list/widgets/homeappbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = Hive.box<Task>(taskBoxName);
  late ThemeData themeData;
  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            HomeAppBar(width: MediaQuery.of(context).size.width, height: 110),
        body: ValueListenableBuilder<Box<Task>>(
            valueListenable: box.listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 80),
                itemCount: box.values.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const HeaderListView();
                  } else {
                    final Task task = box.values.toList()[index - 1];
                    return BodyListView(
                      task: task,
                    );
                    // Text(task.text);
                  }
                },
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: Task()),
                  ));
            },
            label: Row(
              children: [
                Text('Add New tasks'),
                SizedBox(width: 8,),
                FloatingActionButtonWidgets(icon: Icons.add)
              ],
            )),
      ),
    );
  }
}
