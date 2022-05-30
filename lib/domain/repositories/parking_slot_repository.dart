import 'package:parking/domain/models/parking_slot.dart';

abstract class ParkingSlotRepository {

  Future<List<ParkingSlot>> getAll();

  Future<ParkingSlot> get(String id);

  Future<ParkingSlot> save(ParkingSlot parkingSlot);

  Future<ParkingSlot> edit(ParkingSlot parkingSlot);

  Future<ParkingSlot> delete(String id);
}