import 'package:parking/domain/models/parking_registry.dart';

enum RegistryCreateCubitStatus {
  idle,
  loading,
  error,
  success,
}

class RegistryCreateCubitState {
  RegistryCreateCubitStatus status;
  ParkingRegistry? data;
  Exception? error;

  RegistryCreateCubitState({required this.status, this.data, this.error});

  factory RegistryCreateCubitState.initial() => RegistryCreateCubitState(status: RegistryCreateCubitStatus.idle);

  RegistryCreateCubitState copyWith({RegistryCreateCubitStatus? status, ParkingRegistry? data, Exception? error}) {
    return RegistryCreateCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}