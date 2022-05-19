import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  late TextEditingController _controller;
  late ValueNotifier<String> searchValueNotifier;
  @override
  void didChangeDependencies() {
    themeData = Theme.of(context);
    _controller = TextEditingController();
    searchValueNotifier = ValueNotifier('');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
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
                      prefixIcon:
                          const Icon(Icons.search, color: secondaryTextColor),
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
          ),
          Expanded(
              child: ValueListenableBuilder<String>(
                  valueListenable: searchValueNotifier,
                  builder: (context, value, widget) {
                    return ValueListenableBuilder<Box<Task>>(
                        valueListenable: box.listenable(),
                        builder: (context, box, widget) {
                          final List<Task> items;
                          if(_controller.text.isEmpty){
                            items=box.values.toList();

                          }else{
                            items=box.values.where((element) => element.text.contains(_controller.text)).toList();
                          }
                          if (items.isNotEmpty) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.fromLTRB(16, 10, 16, 80),
                              itemCount:items.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const HeaderListView();
                                } else {
                                  final Task task =
                                      items[index - 1];
                                  return BodyListView(
                                    task: task,
                                  );
                                  // Text(task.text);
                                }
                              },
                            );
                          } else {
                            return emptyState();
                          }
                        });
                  }))
        ],
      )),
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
            children: const [
              Text('Add New tasks'),
              SizedBox(
                width: 8,
              ),
              FloatingActionButtonWidgets(icon: Icons.add)
            ],
          )),
    );
  }

//
  Widget emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_state.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Your task List is empty')
        ],
      ),
    );
  }
}
