import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_close_cubit_state.dart';

class RegistryCloseCubit extends Cubit<RegistryCloseCubitState> {
  ParkingRegistryRepository parkingRegistryRepository;

  RegistryCloseCubit({required this.parkingRegistryRepository})
      : super(RegistryCloseCubitState.initial());

  Future closeRegistry(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryCloseCubitStatus.loading));

      registry.exit();
      final closedRegistry = await parkingRegistryRepository.edit(registry);

      emit(state.copyWith(status: RegistryCloseCubitStatus.success, data: closedRegistry));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryCloseCubitStatus.error, error: Exception('')));
    }
  }

}