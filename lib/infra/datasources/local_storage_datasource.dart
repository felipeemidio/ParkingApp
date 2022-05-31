abstract class LocalStorageDatasource {

  Future<void> initialize();

  Future<Map<String, dynamic>> save(String instance, Map<String, dynamic> content);

  Future<Map<String, dynamic>> edit(String instance, String id, Map<String, dynamic> content);

  Future<Map<String, dynamic>> delete(String instance, String id);

  Future<Map<String, dynamic>> get(String instance, String id);

  Future<List<Map<String, dynamic>>> getAll(String instance);

  Future<List<Map<String, dynamic>>> getAllBy(String instance, Map<String, dynamic> conditions);

}