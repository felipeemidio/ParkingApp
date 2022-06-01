import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';

class ParkingRegistryUsecase {
  final ParkingRegistryRepository parkingRegistryRepository;

  ParkingRegistryUsecase({required this.parkingRegistryRepository});

  Future<List<ParkingRegistry>> getAll() async {
    return await parkingRegistryRepository.getAll();
  }

  Future<List<ParkingRegistry>> getAllBy(Map<String, dynamic> conditions) async {
    return await parkingRegistryRepository.getAllBy(conditions);
  }

  Future<ParkingRegistry> get(String id) async {
    return await parkingRegistryRepository.get(id);
  }

  Future<ParkingRegistry> edit(ParkingRegistry parkingSlot) async {
    return await parkingRegistryRepository.edit(parkingSlot);
  }

  Future<ParkingRegistry> save(ParkingRegistry parkingSlot) async {
    return await parkingRegistryRepository.save(parkingSlot);
  }

  Future<ParkingRegistry> delete(ParkingRegistry parkingSlot) async {
    return await parkingRegistryRepository.delete(parkingSlot.id);
  }
}