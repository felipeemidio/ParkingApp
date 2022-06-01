import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit_state.dart';

class RegistryDeleteCubit extends Cubit<RegistryDeleteCubitState> {
  ParkingRegistryRepository parkingRegistryRepository;

  RegistryDeleteCubit({required this.parkingRegistryRepository})
      : super(RegistryDeleteCubitState.initial());

  Future delete(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryDeleteCubitStatus.loading));

      final deletedRegistry = await parkingRegistryRepository.delete(registry.id);

      emit(state.copyWith(status: RegistryDeleteCubitStatus.success, data: deletedRegistry));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryDeleteCubitStatus.error, error: Exception('')));
    }
  }

}