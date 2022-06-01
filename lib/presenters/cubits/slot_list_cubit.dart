import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
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

      final slots = await parkingSlotUsecase.getAll(withRegistries: true);

      emit(state.copyWith(status: SlotListCubitStatus.success, data: slots));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: SlotListCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: SlotListCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}