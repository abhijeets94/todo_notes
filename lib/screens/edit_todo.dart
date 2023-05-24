import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';

class TodoDetailsPage extends ConsumerStatefulWidget {
  TodoDetailsPage(
      {super.key,
      required this.todo,
      required this.index,
      required this.notesColor});
  Todo todo;
  int index;
  Color notesColor;

  @override
  ConsumerState<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends ConsumerState<TodoDetailsPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Box<Todo>? todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box("todos");

    setState(() {
      titleController.text = widget.todo.title;
      descriptionController.text = widget.todo.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.notesColor.withOpacity(0.9),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: widget.notesColor.withOpacity(0.9),
        automaticallyImplyLeading: true,
        brightness: Brightness.dark,
        border: Border.all(color: Colors.transparent),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: CupertinoTextField(
                      controller: titleController,
                      placeholder: widget.todo.title.isEmpty
                          ? "Title"
                          : widget.todo.title,
                      style: const TextStyle(fontSize: 35),
                      decoration:
                          const BoxDecoration(shape: BoxShape.rectangle),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: CupertinoTextField(
                    textAlign: TextAlign.start,
                    controller: descriptionController,
                    placeholder: widget.todo.description.isEmpty
                        ? "Description"
                        : widget.todo.description,
                    autofocus: false,
                    maxLines: 6,
                    style: const TextStyle(fontSize: 30),
                    decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: CupertinoButton(
                      color: widget.notesColor.withAlpha(142),
                      pressedOpacity: 0.2,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        // setState(() {
                        //   todos[widget.index]["description"] =
                        //       descriptionController.text;
                        // });

                        // ref.read(todosRiverpod)[widget.index]["description"] =
                        //     descriptionController.text;
                        if (titleController.text.isEmpty &&
                            descriptionController.text.isEmpty) {
                          Todo(
                            title: widget.todo.title,
                            description: widget.todo.description,
                            status: widget.todo.status,
                            dateOfCreation: widget.todo.dateOfCreation,
                          );
                        } else {
                          todoBox!.putAt(
                              widget.index,
                              Todo(
                                title: titleController.text,
                                description: descriptionController.text,
                                status: widget.todo.status,
                                dateOfCreation: widget.todo.dateOfCreation,
                              ));
                        }
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
