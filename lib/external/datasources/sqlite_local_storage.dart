import 'package:parking/domain/exceptions/exceptions.dart';
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
    try {
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
    } catch (e, st) {
      throw DatasourceException(
        "Error trying to open your Database.",
        error: e,
        stackTrace: st,
      );
    } finally {
      _isInitialized = true;
    }
  }

  Future<void> _holdUntilInitialized() async {
    while(!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String instance) async {
    await _holdUntilInitialized();
    try {
      return await _database!.query(instance);
    } catch (e, st) {
      throw DatasourceException('Error getting all "$instance".', error: e, stackTrace: st);
    }

  }

  @override
  Future<Map<String, dynamic>> get(String instance, String id) async {
    await _holdUntilInitialized();
    try {
      final query = await _database!.query(instance, where: 'id = ?', whereArgs: [id]);
      if(query.isEmpty) {
        throw DatasourceException('Element not found for id "$id".');
      }
      return query.first;
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw DatasourceException('Could not get $instance with "$id"', error: e, stackTrace: st);
    }

  }

  @override
  Future<List<Map<String, dynamic>>> getAllBy(String instance, Map<String, dynamic> conditions) async {
    await _holdUntilInitialized();
    List<String> conditionsList = [];
    try {
      conditions.forEach((key, value) {
        String condition = value is String ? "$key = '$value'" : '$key = $value';
        if(value is List) {
          final formattedValues = value.map((e) => e is String ? "'e'" : e);
          condition = '$key IN (${formattedValues.join(',')})';
        }
        if(value == null) {
          condition = '$key IS NULL';
        }

        conditionsList.add(condition);
      });
      final query = await _database!.query(instance, where: conditionsList.join(' AND '));
      return query;
    } catch(e, st) {
      throw DatasourceException('Could not get all $instance with conditions', error: e, stackTrace: st);
    }

  }

  @override
  Future<Map<String, dynamic>> save(String instance, Map<String, dynamic> content) async {
    await _holdUntilInitialized();
    try {
      await _database!.insert(instance, content);
      return content;
    } catch(e, st) {
      throw DatasourceException('Could not save $instance', error: e, stackTrace: st);
    }
  }

  @override
  Future<Map<String, dynamic>> edit(String instance, String id, Map<String, dynamic> content) async {
    await _holdUntilInitialized();
    try {
      await _database!.update(
        instance,
        content,
        where: 'id = ?',
        whereArgs: [id],
      );

      return await get(instance, id);
    } catch (e, st) {
      throw DatasourceException('Could not edit $instance with id "$id"', error: e, stackTrace: st);
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String instance, String id) async {
    await _holdUntilInitialized();

    try {
      final result = await get(instance, id);
      await _database!.delete(instance, where: 'id = ?', whereArgs: [id]);

      return result;
    } catch (e, st) {
      throw DatasourceException('Could not delete $instance with id "$id"', error: e, stackTrace: st);
    }
  }

}