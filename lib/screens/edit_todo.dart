import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';

class TodoDetailsPage extends ConsumerStatefulWidget {
  TodoDetailsPage({super.key, required this.todo, required this.index});
  Todo todo;
  int index;

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
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        brightness: Brightness.dark,
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
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: CupertinoTextField(
                      controller: titleController,
                      placeholder: widget.todo.title,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: CupertinoTextField(
                    textAlign: TextAlign.start,
                    controller: descriptionController,
                    placeholder: widget.todo.description,
                    autofocus: false,
                    maxLines: 6,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton.filled(
                      child: const Text("Save"),
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
