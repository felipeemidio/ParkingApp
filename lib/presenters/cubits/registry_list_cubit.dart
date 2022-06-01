import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_list_cubit_state.dart';

class RegistryListCubit extends Cubit<RegistryListCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryListCubit({required this.parkingRegistryUsecase})
      : super(RegistryListCubitState.initial());

  Future fetch() async {
    try {
      emit(state.copyWith(status: RegistryListCubitStatus.loading));

      final registries = await parkingRegistryUsecase.getAll();

      emit(state.copyWith(status: RegistryListCubitStatus.success, data: registries));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryListCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: RegistryListCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

  Future fetchBySlotId(String slotId) async {
    try {
      emit(state.copyWith(status: RegistryListCubitStatus.loading));

      final registries = await parkingRegistryUsecase.getAllBySlotId(slotId);

      emit(state.copyWith(status: RegistryListCubitStatus.success, data: registries));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryListCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: RegistryListCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}