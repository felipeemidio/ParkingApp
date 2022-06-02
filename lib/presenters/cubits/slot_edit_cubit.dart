import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_edit_cubit_state.dart';

class SlotEditCubit extends Cubit<SlotEditCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;

  SlotEditCubit({required this.parkingSlotUsecase})
      : super(SlotEditCubitState.initial());

  Future edit(String slotName, ParkingSlot currentSlot) async {
    try {
      emit(state.copyWith(status: SlotEditCubitStatus.loading));


      final slot = await parkingSlotUsecase.edit(currentSlot, slotName);

      emit(state.copyWith(status: SlotEditCubitStatus.success, data: slot));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: SlotEditCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: SlotEditCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}