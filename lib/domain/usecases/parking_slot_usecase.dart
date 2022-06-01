import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';

class ParkingSlotUsecase {
  final ParkingSlotRepository parkingSlotRepository;

  ParkingSlotUsecase({required this.parkingSlotRepository});

  Future<List<ParkingSlot>> getAll() async {
    return await parkingSlotRepository.getAll();
  }

  Future<ParkingSlot> get(String id) async {
    return await parkingSlotRepository.get(id);
  }

  Future<ParkingSlot> edit(ParkingSlot parkingSlot) async {
    return await parkingSlotRepository.edit(parkingSlot);
  }

  Future<ParkingSlot> save(ParkingSlot parkingSlot) async {
    return await parkingSlotRepository.save(parkingSlot);
  }

  Future<ParkingSlot> delete(ParkingSlot parkingSlot) async {
    return await parkingSlotRepository.delete(parkingSlot.id);
  }
}