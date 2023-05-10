abstract class TodoRepositoryInterface {
  Stream<List<Map<String, dynamic>>> listTodos();
  Future<List> readTodos();
  Future createTodo({required String title, required String statusId});
  Future deleteTodo({required int id});
}
