import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_list_cubit_state.dart';

class RegistryListCubit extends Cubit<RegistryListCubitState> {
  ParkingRegistryRepository parkingRegistryRepository;

  RegistryListCubit({required this.parkingRegistryRepository})
      : super(RegistryListCubitState.initial());

  Future fetch() async {
    try {
      emit(state.copyWith(status: RegistryListCubitStatus.loading));

      final registries = await parkingRegistryRepository.getAll();
      registries.sort((r1, r2) => r2.createdAt.compareTo(r1.createdAt));

      emit(state.copyWith(status: RegistryListCubitStatus.success, data: registries));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryListCubitStatus.error, error: Exception('')));
    }
  }

}