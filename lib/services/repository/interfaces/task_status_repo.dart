import '../../../core/models/task_status.dart';

abstract class TaskStatusRepositoryInterface{
  Future<TaskStatus> getStatusFromTodo(String statusId);
  Future<List<TaskStatus>> getListStatus();
}