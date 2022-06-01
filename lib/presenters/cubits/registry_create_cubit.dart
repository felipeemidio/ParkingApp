import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_create_cubit_state.dart';
import 'package:uuid/uuid.dart';

class RegistryCreateCubit extends Cubit<RegistryCreateCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryCreateCubit({required this.parkingRegistryUsecase})
      : super(RegistryCreateCubitState.initial());

  Future save(String slotId, String licensePlate, String? observations) async {
    try {
      emit(state.copyWith(status: RegistryCreateCubitStatus.loading));

      final newRegistry = ParkingRegistry(
        id: const Uuid().v4(),
        licensePlate: licensePlate,
        slotId: slotId,
        createdAt: DateTime.now(),
        observations: observations,
      );
      final registry = await parkingRegistryUsecase.save(newRegistry);

      emit(state.copyWith(status: RegistryCreateCubitStatus.success, data: registry));
    } catch(e, st) {
      print(e);
      print(st);
      emit(state.copyWith(status: RegistryCreateCubitStatus.error, error: Exception('')));
    }
  }

}