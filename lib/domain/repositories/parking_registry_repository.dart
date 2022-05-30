import 'package:parking/domain/models/parking_registry.dart';

abstract class ParkingRegistryRepository {

  Future<List<ParkingRegistry>> getAll();

  Future<ParkingRegistry> get(String id);

  Future<ParkingRegistry> save(ParkingRegistry parkingRegistry);

  Future<ParkingRegistry> edit(ParkingRegistry parkingRegistry);

  Future<ParkingRegistry> delete(String id);
}