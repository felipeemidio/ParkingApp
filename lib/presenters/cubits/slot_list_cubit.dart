import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';

class SlotListCubit extends Cubit<SlotListCubitState> {
  ParkingSlotRepository parkingSlotRepository;
  ParkingRegistryRepository parkingRegistryRepository;

  SlotListCubit({required this.parkingSlotRepository, required this.parkingRegistryRepository})
      : super(SlotListCubitState.initial());

  Future fetch() async {
    try {
      emit(state.copyWith(status: SlotListCubitStatus.loading));
      final slots = await parkingSlotRepository.getAll();
      final openRegistries = await parkingRegistryRepository.getAllBy({'endedAt': null});
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