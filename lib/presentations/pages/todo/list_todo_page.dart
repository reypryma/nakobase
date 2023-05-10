import 'package:flutter/material.dart';
import 'package:nakobase/core/models/todo.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/data/object_transform.dart';
import 'package:nakobase/presentations/components/single_todo_component.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:provider/provider.dart';

class ListTodoPage extends StatefulWidget {

  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  late Stream<List<Map<String, dynamic>>> readStream;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      readStream = todoRepository.listTodos();
      await todoRepository.readTodos();
    } catch (e) {

    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {


    return (isLoading == false)
        ? StreamBuilder(
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

              if (snapshot.connectionState == ConnectionState.waiting) {
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
                      Future.delayed(const Duration(seconds: 2));
                      final newTodoJson = addObjectToMap(
                          model: Provider.of<TaskStatusProvider>(context,
                                  listen: false)
                              .statusList[int.parse(snapshot.data![index]
                                      ['status_id']
                                  .toString()) -
                              1],
                          keyForNewModel: 'status',
                          originalMap: snapshot.data![index]);

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection direction) async{
                          try {
                            print('get ${ snapshot.data![index]['id']}');
                            await todoRepository.deleteTodo(id: snapshot.data![index]['id']).whenComplete(() => showCustomSnackBar('Success delete', context));
                          } on Exception catch (e) {
                            showCustomSnackBar("$e", context);
                          }
                          setState(
                                () {

                            },
                          );
                        },
                        child: SingleTodoComponent(
                          todo: Todo.fromJSON(newTodoJson),
                        ),
                      );
                    });
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(
                child: Text("No data available"),
              );
            })
        : Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: icNavyBlueColor,
            ),
          );
  }
}
