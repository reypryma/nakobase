import 'package:flutter/material.dart';
import 'package:nakobase/core/models/task_status.dart';
import 'package:nakobase/core/service_locator.dart';

class TaskStatusProvider extends ChangeNotifier{

  List<TaskStatus> statusList = [];

  Future<void> getStatusList() async{
    statusList = await taskStatusRepository.getListStatus();
    print('################## ${statusList}');
    notifyListeners();
  }
}