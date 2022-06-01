import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_close_cubit_state.dart';

class RegistryCloseCubit extends Cubit<RegistryCloseCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryCloseCubit({required this.parkingRegistryUsecase})
      : super(RegistryCloseCubitState.initial());

  Future closeRegistry(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryCloseCubitStatus.loading));

      registry.exit();
      final closedRegistry = await parkingRegistryUsecase.edit(registry);

      emit(state.copyWith(status: RegistryCloseCubitStatus.success, data: closedRegistry));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryCloseCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
        status: RegistryCloseCubitStatus.error,
        error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}