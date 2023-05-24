import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/add_todo.dart';

import 'edit_todo.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsmerState();
}

class _HomePageConsmerState extends ConsumerState<HomePage> {
  Box<Todo>? todoBox;

  @override
  void initState() {
    super.initState();
    todoBox ??= Hive.box("todos");
  }

  @override
  Widget build(BuildContext context) {
    return todoBox!.isEmpty
        ? SafeArea(
            child: Scaffold(
              body: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddTodo()));
                },
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    " + Tap to add new note",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 7,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              border: Border.all(color: Colors.transparent),
              middle: Text(
                "NOTES!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              trailing: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddTodo())),
                  child: const Icon(CupertinoIcons.add)),
            ),
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Todo>('todos').listenable(),
                builder: (context, todoBox, widget) {
                  return ListView.builder(
                    physics: todoBox.length <= 4
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    shrinkWrap: true,
                    itemCount: todoBox.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TodoDetailsPage(
                                todo: todoBox.getAt(index)!,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (val) {
                            debugPrint("val => $val");
                            if (val == DismissDirection.startToEnd) {
                              todoBox.deleteAt(index);
                            }
                            if (val == DismissDirection.endToStart) {
                              todoBox.putAt(
                                index,
                                Todo(
                                  title: todoBox.getAt(index)!.title,
                                  description:
                                      todoBox.getAt(index)!.description,
                                  status: !(todoBox.getAt(index)!.status),
                                  dateOfCreation:
                                      todoBox.getAt(index)!.dateOfCreation,
                                ),
                              );
                            }
                          },
                          background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )),
                          secondaryBackground: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )),
                          direction: DismissDirection.horizontal,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(10),
                            // height: 70,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color((Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(0.4),
                              // border: Border.all(width: 1.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                              .toInt())
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 2.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${todoBox.getAt(index)?.title}',
                                  style: TextStyle(
                                    decoration: todoBox.getAt(index)!.status
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${todoBox.getAt(index)?.description}',
                                  style: TextStyle(
                                      decoration: todoBox.getAt(index)!.status
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                Text(
                                  '${DateTime.parse(todoBox.getAt(index)!.dateOfCreation).day} - ${DateTime.parse(todoBox.getAt(index)!.dateOfCreation).month} - ${DateTime.parse(todoBox.getAt(index)!.dateOfCreation).year}',
                                  style: TextStyle(
                                      decoration: todoBox.getAt(index)!.status
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black),
                                ),

                                // Consumer(builder: (context, ref, _) {
                                // var todoRiverpod = ref.watch(todosRiverpod);
                                // return Text("$todoRiverpod");
                                // })
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }));
  }
}
