import 'package:parking/domain/models/parking_registry.dart';

enum RegistryDeleteCubitStatus {
  idle,
  loading,
  error,
  success,
}

class RegistryDeleteCubitState {
  RegistryDeleteCubitStatus status;
  ParkingRegistry? data;
  Exception? error;

  RegistryDeleteCubitState({required this.status, this.data, this.error});

  factory RegistryDeleteCubitState.initial() => RegistryDeleteCubitState(status: RegistryDeleteCubitStatus.idle);

  RegistryDeleteCubitState copyWith({RegistryDeleteCubitStatus? status, ParkingRegistry? data, Exception? error}) {
    return RegistryDeleteCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistryDeleteCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}