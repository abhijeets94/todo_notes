import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';

class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Box<Todo> todoBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box("todos");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            // leading: GestureDetector(
            //     onTap: () => Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => const HomePage())),
            //     child: const Icon(CupertinoIcons.back)),
            automaticallyImplyLeading: true,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CupertinoTextField(
                    controller: titleController,
                    placeholder: "Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: CupertinoTextField(
                      controller: descriptionController,
                      placeholder: "Description",
                      // maxLength: 120,
                      maxLines: 5,
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
                          // todos.add(
                          //   {
                          //     "title": titleController.text,
                          //     "description": descriptionController.text,
                          //     "date": DateTime.now(),
                          //   },
                          // );
                          final todos = Todo(
                              title: titleController.text,
                              description: descriptionController.text,
                              status: false,
                              dateOfCreation: DateTime.now().toString());
                          todoBox.put(titleController.text, todos);
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
