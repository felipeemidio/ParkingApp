import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_edit_cubit_state.dart';

class RegistryEditCubit extends Cubit<RegistryEditCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryEditCubit({required this.parkingRegistryUsecase})
      : super(RegistryEditCubitState.initial());

  Future edit(ParkingRegistry registry) async {
    try {
      emit(state.copyWith(status: RegistryEditCubitStatus.loading));

      final deletedRegistry = await parkingRegistryUsecase.edit(registry);

      emit(state.copyWith(status: RegistryEditCubitStatus.success, data: deletedRegistry));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryEditCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: RegistryEditCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}