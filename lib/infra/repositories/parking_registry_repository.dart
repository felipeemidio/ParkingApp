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
    final rawResult = await localStorageDatasource.getAll(instance);
    return rawResult.map((e) => ParkingRegistry.fromMap(e)).toList();
  }

  @override
  Future<ParkingRegistry> get(String id) async {
    final rawResult = await localStorageDatasource.get(instance, id);
    return ParkingRegistry.fromMap(rawResult);
  }

  @override
  Future<ParkingRegistry> save(ParkingRegistry parkingRegistry) async {
    final rawResult = await localStorageDatasource.save(instance, parkingRegistry.toMap());
    return ParkingRegistry.fromMap(rawResult);
  }

  @override
  Future<ParkingRegistry> edit(ParkingRegistry parkingRegistry) async {
    final rawResult = await localStorageDatasource.edit(instance, parkingRegistry.id, parkingRegistry.toMap());
    return ParkingRegistry.fromMap(rawResult);
  }

  @override
  Future<ParkingRegistry> delete(String id) async {
    final rawResult = await localStorageDatasource.delete(instance, id);
    return ParkingRegistry.fromMap(rawResult);
  }

}