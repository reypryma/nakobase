import 'package:nakobase/core/models/task_status.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/services/repository/interfaces/task_status_repo.dart';

class TaskStatusRepositoryImpl implements TaskStatusRepositoryInterface{
  @override
  Future<TaskStatus> getStatusFromTodo(String statusId) async{
    Map<String, dynamic> taskJson = await supabaseService.init().from('task_status').select().eq('id', statusId).single();
    return TaskStatus.fromJSON(taskJson);
  }

  @override
  Future<List<TaskStatus>> getListStatus() async{
    List fetchStatus = await supabaseService.init().from('task_status').select().order('id',ascending: true);

    List<Map<String,dynamic>> dataDecode= fetchStatus.cast<Map<String, dynamic>>().toList();

    print('list task status ${dataDecode}');

    return dataDecode.map((e) => TaskStatus.fromJSON(e)).toList();
  }
}

