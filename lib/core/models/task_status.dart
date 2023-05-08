
class TaskStatus{
    int? id;
    String? taskStatusName;

    TaskStatus({this.id, this.taskStatusName});

    factory TaskStatus.fromJSON(Map<String, dynamic> json){
      return TaskStatus(
          id: json['id'],
          taskStatusName: json['name'],
      );
    }

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> data = <String, dynamic>{};
      if (id != null) data['id'] = id;
      if (taskStatusName != null) data['name'] = taskStatusName;
      return data;
    }
}

enum TaskStatusType{
  planned,
  ongoing,
  done,
}

extension TaskStatusExtension on TaskStatusType{
  String get name {
    switch (this) {
      case TaskStatusType.planned:
        return 'planned';
      case TaskStatusType.ongoing:
        return 'ongoing';
      case TaskStatusType.done:
        return 'done';
      default:
        return 'planned';
    }
  }

  int toID() {
    switch (this) {
      case TaskStatusType.planned:
        return 1;
      case TaskStatusType.ongoing:
        return 2;
      case TaskStatusType.done:
        return 3;
      default:
        return 1;
    }
  }
}