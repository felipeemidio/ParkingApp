import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';

class SlotListCubit extends Cubit<SlotListCubitState> {
  ParkingSlotUsecase parkingSlotUsecase;
  ParkingRegistryUsecase parkingRegistryUsecase;

  SlotListCubit({required this.parkingSlotUsecase, required this.parkingRegistryUsecase})
      : super(SlotListCubitState.initial());

  Future fetch() async {
    try {
      emit(state.copyWith(status: SlotListCubitStatus.loading));
      final slots = await parkingSlotUsecase.getAll();
      final openRegistries = await parkingRegistryUsecase.getAllBy({'endedAt': null});
      for(ParkingRegistry registry in openRegistries) {
        final indexOfSlot = slots.indexWhere((element) => registry.slotId == element.id);
        if(indexOfSlot >= 0) {
          slots[indexOfSlot].currentRegistry = registry;
        } else {
          print('slot without index');
        }
      }
      emit(state.copyWith(status: SlotListCubitStatus.success, data: slots));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: SlotListCubitStatus.error, error: Exception('')));
    }
  }

}