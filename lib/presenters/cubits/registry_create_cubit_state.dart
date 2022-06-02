import 'package:parking/domain/exceptions/exceptions.dart';
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
  ParkingException? error;

  RegistryCreateCubitState({required this.status, this.data, this.error});

  factory RegistryCreateCubitState.initial() => RegistryCreateCubitState(status: RegistryCreateCubitStatus.idle);

  RegistryCreateCubitState copyWith({RegistryCreateCubitStatus? status, ParkingRegistry? data, ParkingException? error}) {
    return RegistryCreateCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return {'status': status.name, 'data': data, 'error': error,}.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistryCreateCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}