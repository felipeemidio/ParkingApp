import 'package:parking/domain/models/parking_registry.dart';

enum RegistryCloseCubitStatus {
  idle,
  loading,
  error,
  success,
}

class RegistryCloseCubitState {
  RegistryCloseCubitStatus status;
  ParkingRegistry? data;
  Exception? error;

  RegistryCloseCubitState({required this.status, this.data, this.error});

  factory RegistryCloseCubitState.initial() => RegistryCloseCubitState(status: RegistryCloseCubitStatus.idle);

  RegistryCloseCubitState copyWith({RegistryCloseCubitStatus? status, ParkingRegistry? data, Exception? error}) {
    return RegistryCloseCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistryCloseCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}