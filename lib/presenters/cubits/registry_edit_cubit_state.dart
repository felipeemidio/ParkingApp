import 'package:parking/domain/models/parking_registry.dart';

enum RegistryEditCubitStatus {
  idle,
  loading,
  error,
  success,
}

class RegistryEditCubitState {
  RegistryEditCubitStatus status;
  ParkingRegistry? data;
  Exception? error;

  RegistryEditCubitState({required this.status, this.data, this.error});

  factory RegistryEditCubitState.initial() => RegistryEditCubitState(status: RegistryEditCubitStatus.idle);

  RegistryEditCubitState copyWith({RegistryEditCubitStatus? status, ParkingRegistry? data, Exception? error}) {
    return RegistryEditCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistryEditCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}