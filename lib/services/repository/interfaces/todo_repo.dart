abstract class TodoRepositoryInterface {
  Stream<List<Map<String, dynamic>>> listTodos();
  Future<List> readTodos();
}
