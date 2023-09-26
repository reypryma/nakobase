import 'package:nakobase/core/models/task_status.dart';

class Todo {
  int id;
  String? title;
  String? userId;
  TaskStatus status;
  String? updatedAt;

  Todo(
      {required this.id,
      this.title,
      this.userId,
      required this.status,
      this.updatedAt});

  factory Todo.fromJSON(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      userId: data['user_id'],
      title: data['title'],
      status: TaskStatus.fromJSON(data['status']),
      updatedAt: data['updated_at'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) data['title'] = title;
    if (userId != null) data['user_id'] = userId;
    data['status_id'] = status.id;
    return data;
  }
}
