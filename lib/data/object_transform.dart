import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

List<T> mapDynamicListToListObject<T>(
    List<dynamic> list, T Function(Map<String, dynamic>) mapFunction) {
  List<Map<String, dynamic>> mappedList =
      list.cast<Map<String, dynamic>>().toList();
  List<T> objectList = mappedList.map((e) => mapFunction(e)).toList();
  return objectList;
}

T toEnumValue<T>(
  String data, {
  required List<T> values,
}) {
  return values.firstWhere(
    (T value) => describeEnum(value!) == data,
    orElse: () => values.firstWhere(
      (T value) => describeEnum(value!) == 'UNKNOWN',
    ),
  );
}

List<T> toEnumValueList<T>(
  List<String> dataList, {
  required List<T> values,
}) {
  return dataList
      .map(
        (String data) => toEnumValue(
          data,
          values: values,
        ),
      )
      .toList();
}

T inject<T extends Object>() {
  return GetIt.I.get<T>();
}

Map<String, dynamic> addObjectToMap  (
    {required dynamic model, required String keyForNewModel, required Map<String, dynamic> originalMap}){
  originalMap[keyForNewModel] = model.toJson();
  return originalMap;
}
