import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';

class ParkingSlotUsecase {
  final ParkingSlotRepository parkingSlotRepository;
  final ParkingRegistryRepository parkingRegistryRepository;

  ParkingSlotUsecase({
    required this.parkingSlotRepository,
    required this.parkingRegistryRepository,
  });

  Future<List<ParkingSlot>> getAll({bool withRegistries = false}) async {
    final slots = await parkingSlotRepository.getAll();
    if(withRegistries) {
      final openRegistries = await parkingRegistryRepository.getAllBy({'endedAt': null});
      for(ParkingRegistry registry in openRegistries) {
        final indexOfSlot = slots.indexWhere((element) => registry.slotId == element.id);
        if(indexOfSlot >= 0) {
          slots[indexOfSlot].currentRegistry = registry;
        } else {
          throw UsecaseException('Open registry for slot "${registry.slotId}"');
        }
      }
    }
    return slots;
  }

  Future<ParkingSlot> get(String id) async {
    return await parkingSlotRepository.get(id);
  }

  Future<ParkingSlot> edit(ParkingSlot parkingSlot, String slotName) async {
    parkingSlot.name = slotName;
    return await parkingSlotRepository.edit(parkingSlot);
  }

  Future<ParkingSlot> save(ParkingSlot parkingSlot) async {
    return await parkingSlotRepository.save(parkingSlot);
  }

  Future<ParkingSlot> delete(ParkingSlot parkingSlot) async {
    return await parkingSlotRepository.delete(parkingSlot.id);
  }
}