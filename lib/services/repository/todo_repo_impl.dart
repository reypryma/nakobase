import 'package:flutter/foundation.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/services/repository/interfaces/todo_repo.dart';

import '../../core/models/todo.dart';

class TodoRepositoryImp implements TodoRepositoryInterface{
  @override
  Stream<List<Map<String, dynamic>>> listTodos() {
    // List<Map<String, dynamic>> saved = [];

    final data = supabaseService.init().from('todos').stream(primaryKey: ['id']).eq('user_id', authRepository.getCurrentUser()!.id).order('id',ascending: false);
    // data.map((event){
    //   saved = List<Map<String, dynamic>>.from(event);
    // });
    // if (kDebugMode) {
    //   print('get todos: $saved');
    // }

    return data;
  }

  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    try {
      // List data = await supabaseService.init().from('todos').select().eq('user_id', authRepository.getCurrentUser()!.id).order('id',ascending: false);

      final dataList = await supabaseService.init().from('todos').select('id, title, updated_at, task_status(*)').eq('user_id', authRepository.getCurrentUser()!.id).order('id',ascending: false);

      if (kDebugMode) {
        print('get list: ${dataList.cast<Map<String, dynamic>>().toList()}');
      }

      List<Map<String, dynamic>> convertToListMap = dataList.cast<Map<String, dynamic>>().toList();

      List<Todo> convertToListObjects = convertToListMap.map((e) => Todo.fromJSON(e)).toList();

      if (kDebugMode) {
        print('get object: ${convertToListObjects[1].status.taskStatusName}');
      }

      return convertToListMap;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future createTodo({required String title, required String statusId}) async{
    try {
      String userId = supabaseService.init().auth.currentUser!.id;
      await supabaseService.init().from('todos').insert({'title': title, 'status_id': statusId, 'user_id':userId});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future deleteTodo({required int id}) async{
      try {
        String userId = authRepository.getCurrentUser()!.id;
        await supabaseService.init().from('todos').delete().match({'id': id, 'user_id': userId});
      } catch (e) {
        print(e);
      }
  }
}