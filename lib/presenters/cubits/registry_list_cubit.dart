import 'package:flutter_bloc/flutter_bloc.dart';
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
      registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));

      emit(state.copyWith(status: RegistryListCubitStatus.success, data: registries));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryListCubitStatus.error, error: Exception('')));
    }
  }

  Future fetchBySlotId(String slotId) async {
    try {
      emit(state.copyWith(status: RegistryListCubitStatus.loading));

      final registries = await parkingRegistryUsecase.getAllBy({'slotId': slotId});
      registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));

      emit(state.copyWith(status: RegistryListCubitStatus.success, data: registries));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryListCubitStatus.error, error: Exception('')));
    }
  }

}