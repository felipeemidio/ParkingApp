import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';

class SlotDeleteCubit extends Cubit<SlotDeleteCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;

  SlotDeleteCubit({required this.parkingSlotUsecase})
      : super(SlotDeleteCubitState.initial());

  Future delete(ParkingSlot parkingSlot) async {
    try {
      emit(state.copyWith(status: SlotDeleteCubitStatus.loading));

      final slot = await parkingSlotUsecase.delete(parkingSlot);

      emit(state.copyWith(status: SlotDeleteCubitStatus.success, data: slot));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: SlotDeleteCubitStatus.error, error: Exception('')));
    }
  }

}