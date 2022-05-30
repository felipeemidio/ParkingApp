import 'package:parking/external/datasources/consts.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';
import 'package:sqflite/sqflite.dart';

class SqliteLocalStorage extends LocalStorageDatasource {
  static const _kDatabaseName = 'parking_db.db';
  Database? _database;
  bool _isInitialized = false;

  SqliteLocalStorage(){
    initialize();
  }

  @override
  Future<void> initialize() async {
    _isInitialized = false;
    _database = await openDatabase(
      _kDatabaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $kParkingSlotTableName ('
                '$kParkingSlotIdColumn String PRIMARY KEY, '
                '$kParkingSlotNameColumn TEXT, '
                '$kParkingSlotCreatedAtColumn TEXT)'
        );
        await db.execute(
            'CREATE TABLE $kParkingRegistryTableName ('
                '$kParkingRegistryIdColumn String PRIMARY KEY, '
                '$kParkingRegistryCreatedAtColumn TEXT, '
                '$kParkingRegistryEndedAtColumn TEXT, '
                '$kParkingRegistryLicensePlateColumn TEXT, '
                '$kParkingRegistrySlotIdColumn TEXT, '
                '$kParkingRegistryObservationsColumn TEXT)');
      });
    _isInitialized = true;
  }

  Future<void> _holdUntilInitialized() async {
    while(!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String instance) async {
    await _holdUntilInitialized();
    return await _database!.query(instance);
  }

  @override
  Future<Map<String, dynamic>> get(String instance, String id) async {
    await _holdUntilInitialized();

    final query = await _database!.query(instance, where: 'id = ?', whereArgs: [id]);
    if(query.isEmpty) {
      throw Exception('Element not found for id "$id".');
    }
    return query.first;
  }

  @override
  Future<Map<String, dynamic>> save(String instance, Map<String, dynamic> content) async {
    await _holdUntilInitialized();

    await _database!.insert(instance, content);
    return content;
  }

  @override
  Future<Map<String, dynamic>> edit(String instance, String id, Map<String, dynamic> content) async {
    await _holdUntilInitialized();

    await _database!.update(
      instance,
      content,
      where: 'id = ?',
      whereArgs: [id],
    );

    return await get(instance, id);
  }

  @override
  Future<Map<String, dynamic>> delete(String instance, String id) async {
    await _holdUntilInitialized();

    final result = await get(instance, id);
    await _database!.delete(instance, where: 'id = ?', whereArgs: [id]);

    return result;
  }

}