import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:uuid/uuid.dart';

class ParkingRegistryUsecase {
  final ParkingRegistryRepository parkingRegistryRepository;

  ParkingRegistryUsecase({required this.parkingRegistryRepository});

  Future<List<ParkingRegistry>> getAll() async {
    final registries = await parkingRegistryRepository.getAll();
    registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));
    return registries;
  }

  Future<List<ParkingRegistry>> getAllBySlotId(String slotId) async {
    final registries = await parkingRegistryRepository.getAllBy({'slotId': slotId});
    registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));
    return registries;
  }

  Future<List<ParkingRegistry>> getAllParked() async {
    final registries = await parkingRegistryRepository.getAllBy({'endedAt': null});
    registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));
    return registries;
  }

  Future<ParkingRegistry> get(String id) async {
    return await parkingRegistryRepository.get(id);
  }

  Future<ParkingRegistry> close(ParkingRegistry parkingSlot) async {
    parkingSlot.exit();
    return await parkingRegistryRepository.edit(parkingSlot);
  }

  Future<ParkingRegistry> edit(ParkingRegistry parkingSlot) async {
    return await parkingRegistryRepository.edit(parkingSlot);
  }

  Future<ParkingRegistry> save(String slotId, String licensePlate, String? observations) async {
    final newRegistry = ParkingRegistry(
      id: const Uuid().v4(),
      licensePlate: licensePlate,
      slotId: slotId,
      createdAt: DateTime.now(),
      observations: observations,
    );
    return await parkingRegistryRepository.save(newRegistry);
  }

  Future<ParkingRegistry> delete(ParkingRegistry parkingSlot) async {
    return await parkingRegistryRepository.delete(parkingSlot.id);
  }
}