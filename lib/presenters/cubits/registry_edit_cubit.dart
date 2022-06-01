import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_edit_cubit_state.dart';

class RegistryEditCubit extends Cubit<RegistryEditCubitState> {
  ParkingRegistryRepository parkingRegistryRepository;

  RegistryEditCubit({required this.parkingRegistryRepository})
      : super(RegistryEditCubitState.initial());

  Future edit(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryEditCubitStatus.loading));

      final deletedRegistry = await parkingRegistryRepository.edit(registry);

      emit(state.copyWith(status: RegistryEditCubitStatus.success, data: deletedRegistry));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryEditCubitStatus.error, error: Exception('')));
    }
  }

}