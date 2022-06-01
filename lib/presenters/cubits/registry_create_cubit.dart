import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_create_cubit_state.dart';

class RegistryCreateCubit extends Cubit<RegistryCreateCubitState> {
  ParkingRegistryUsecase parkingRegistryUsecase;

  RegistryCreateCubit({required this.parkingRegistryUsecase})
      : super(RegistryCreateCubitState.initial());

  Future save(String slotId, String licensePlate, String? observations) async {
    try {
      emit(state.copyWith(status: RegistryCreateCubitStatus.loading));

      final registry = await parkingRegistryUsecase.save(slotId, licensePlate, observations);

      emit(state.copyWith(status: RegistryCreateCubitStatus.success, data: registry));
    } on ParkingException catch (e) {
      emit(state.copyWith(status: RegistryCreateCubitStatus.error, error: e));
    } catch(e, st) {
      emit(state.copyWith(
          status: RegistryCreateCubitStatus.error,
          error: CubitException('Unknown Error', error: e, stackTrace: st)),
      );
    }
  }

}