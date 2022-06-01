import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/external/datasources/consts.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';

class ParkingRegistryRepositoryImpl extends ParkingRegistryRepository {
  final instance = kParkingRegistryTableName;

  final LocalStorageDatasource localStorageDatasource;

  ParkingRegistryRepositoryImpl({required this.localStorageDatasource});

  @override
  Future<List<ParkingRegistry>> getAll() async {
    try {
      final rawResult = await localStorageDatasource.getAll(instance);
      return rawResult.map((e) => ParkingRegistry.fromMap(e)).toList();
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

  @override
  Future<List<ParkingRegistry>> getAllBy(Map<String, dynamic> conditions) async {
    try {
      final rawResult = await localStorageDatasource.getAllBy(instance, conditions);
      return rawResult.map((e) => ParkingRegistry.fromMap(e)).toList();
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingRegistry> get(String id) async {
    try {
      final rawResult = await localStorageDatasource.get(instance, id);
      return ParkingRegistry.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingRegistry> save(ParkingRegistry parkingRegistry) async {
    try {
      final rawResult = await localStorageDatasource.save(instance, parkingRegistry.toMap());
      return ParkingRegistry.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingRegistry> edit(ParkingRegistry parkingRegistry) async {
    try {
      final rawResult = await localStorageDatasource.edit(instance, parkingRegistry.id, parkingRegistry.toMap());
      return ParkingRegistry.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingRegistry> delete(String id) async {
    try {
      final rawResult = await localStorageDatasource.delete(instance, id);
      return ParkingRegistry.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingRegistry', error: e, stackTrace: st);
    }
  }

}