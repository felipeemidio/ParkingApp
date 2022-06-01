import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_create_cubit_state.dart';
import 'package:uuid/uuid.dart';

class SlotCreateCubit extends Cubit<SlotCreateCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;

  SlotCreateCubit({required this.parkingSlotUsecase})
      : super(SlotCreateCubitState.initial());

  Future save(String slotName) async {
    try {
      emit(state.copyWith(status: SlotCreateCubitStatus.loading));

      final newSlot = ParkingSlot(
          id: const Uuid().v4(),
          name: slotName,
          createdAt: DateTime.now(),
      );
      final slot = await parkingSlotUsecase.save(newSlot);

      emit(state.copyWith(status: SlotCreateCubitStatus.success, data: slot));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: SlotCreateCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: SlotCreateCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}