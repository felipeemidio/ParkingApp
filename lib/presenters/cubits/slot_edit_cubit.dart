import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_create_cubit_state.dart';

class SlotEditCubit extends Cubit<SlotCreateCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;

  SlotEditCubit({required this.parkingSlotUsecase})
      : super(SlotCreateCubitState.initial());

  Future edit(String slotName, ParkingSlot currentSlot) async {
    try {
      emit(state.copyWith(status: SlotCreateCubitStatus.loading));

      currentSlot.name = slotName;
      final slot = await parkingSlotUsecase.edit(currentSlot);

      emit(state.copyWith(status: SlotCreateCubitStatus.success, data: slot));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: SlotCreateCubitStatus.error, error: Exception('')));
    }
  }

}