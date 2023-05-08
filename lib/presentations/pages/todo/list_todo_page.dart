import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakobase/core/models/todo.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/presentations/components/single_todo_component.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:provider/provider.dart';

class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  late Stream<List<Map<String, dynamic>>> readStream;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    try {
      readStream = todoRepository.listTodos();
      // await todoRepository.readTodos();
    } catch (e) {
      showCustomSnackBar(
        '$e',
        context,
      );
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: readStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: icNavyBlueColor,
              ),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> todoJson = snapshot.data![index]; // var {} map todo

                  int statusIndex = int.parse(todoJson['status_id'].toString())-1;
                  print('status statusIndex : $statusIndex');

                  todoJson['status'] = Provider.of<TaskStatusProvider>(context, listen: false).statusList[statusIndex].toJson(); // var {} map status
                  print('task status to get: ${todoJson['status']} where the map of todo $todoJson');

                  Todo todoObject = Todo.fromJSON(todoJson);
                  print('I got the ${todoObject.status.taskStatusName} and ${todoObject.title}');


                  return SingleTodoComponent(todo: todoObject,);
                });
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        });
  }
}
