import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';

class SlotListCubit extends Cubit<SlotListCubitState> {
  ParkingSlotRepository parkingSlotRepository;

  SlotListCubit({required this.parkingSlotRepository})
      : super(SlotListCubitState.initial());

  Future fetch() async {
    try {
      emit(state.copyWith(status: SlotListCubitStatus.loading));
      final slots = await parkingSlotRepository.getAll();
      emit(state.copyWith(status: SlotListCubitStatus.success, data: slots));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: SlotListCubitStatus.error, error: Exception('')));
    }
  }

}