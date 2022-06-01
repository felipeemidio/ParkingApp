import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/external/datasources/consts.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';

class ParkingSlotRepositoryImpl extends ParkingSlotRepository {
  final instance = kParkingSlotTableName;

  final LocalStorageDatasource localStorageDatasource;

  ParkingSlotRepositoryImpl({required this.localStorageDatasource});

  @override
  Future<List<ParkingSlot>> getAll() async {
    try {
      final rawResult = await localStorageDatasource.getAll(instance);
      return rawResult.map((e) => ParkingSlot.fromMap(e)).toList();
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingSlot', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingSlot> get(String id) async {
    try {
      final rawResult = await localStorageDatasource.get(instance, id);
      return ParkingSlot.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingSlot', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingSlot> save(ParkingSlot parkingSlot) async {
    try {
      final rawResult = await localStorageDatasource.save(instance, parkingSlot.toMap());
      return ParkingSlot.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingSlot', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingSlot> edit(ParkingSlot parkingSlot) async {
    try {
      final rawResult = await localStorageDatasource.edit(instance, parkingSlot.id, parkingSlot.toMap());
      return ParkingSlot.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingSlot', error: e, stackTrace: st);
    }
  }

  @override
  Future<ParkingSlot> delete(String id) async {
    try {
      final rawResult = await localStorageDatasource.delete(instance, id);
      return ParkingSlot.fromMap(rawResult);
    } on DatasourceException {
      rethrow;
    } catch (e, st) {
      throw RepositoryException('Could not import ParkingSlot', error: e, stackTrace: st);
    }
  }

}