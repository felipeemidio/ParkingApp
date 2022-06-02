import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';

class SlotDeleteCubit extends Cubit<SlotDeleteCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;
  ParkingRegistryUsecase parkingRegistryUsecase;

  SlotDeleteCubit({required this.parkingSlotUsecase, required this.parkingRegistryUsecase})
      : super(SlotDeleteCubitState.initial());

  Future delete(ParkingSlot parkingSlot) async {
    try {
      emit(state.copyWith(status: SlotDeleteCubitStatus.loading));

      final registries = await parkingRegistryUsecase.getAllBySlotId(parkingSlot.id);
      final indexOfOpenRegistry = registries.indexWhere((e) => e.endedAt == null);
      if(indexOfOpenRegistry >= 0) {
        throw UsecaseException('Cannot delete slot with open registry.');
      }

      final slot = await parkingSlotUsecase.delete(parkingSlot);

      emit(state.copyWith(status: SlotDeleteCubitStatus.success, data: slot));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: SlotDeleteCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: SlotDeleteCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}