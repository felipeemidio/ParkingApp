import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit_state.dart';

class RegistryDeleteCubit extends Cubit<RegistryDeleteCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryDeleteCubit({required this.parkingRegistryUsecase})
      : super(RegistryDeleteCubitState.initial());

  Future delete(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryDeleteCubitStatus.loading));

      final deletedRegistry = await parkingRegistryUsecase.delete(registry);

      emit(state.copyWith(status: RegistryDeleteCubitStatus.success, data: deletedRegistry));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryDeleteCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: RegistryDeleteCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}