import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';

class ParkingSlotUsecase {
  final ParkingSlotRepository parkingSlotRepository;

  ParkingSlotUsecase({required this.parkingSlotRepository});

  Future<List<ParkingSlot>> getAll() async {
    return await parkingSlotRepository.getAll();
  }
}