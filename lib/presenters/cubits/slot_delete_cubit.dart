import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';

class SlotDeleteCubit extends Cubit<SlotDeleteCubitState> {
  ParkingSlotRepository parkingSlotRepository;

  SlotDeleteCubit({required this.parkingSlotRepository})
      : super(SlotDeleteCubitState.initial());

  Future delete(ParkingSlot parkingSlot) async {
    try {
      emit(state.copyWith(status: SlotDeleteCubitStatus.loading));

      final slot = await parkingSlotRepository.delete(parkingSlot.id);

      emit(state.copyWith(status: SlotDeleteCubitStatus.success, data: slot));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: SlotDeleteCubitStatus.error, error: Exception('')));
    }
  }

}