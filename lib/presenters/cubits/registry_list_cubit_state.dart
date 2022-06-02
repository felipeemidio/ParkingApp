import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';

enum RegistryListCubitStatus {
  idle,
  loading,
  error,
  success,
}

class RegistryListCubitState {
  RegistryListCubitStatus status;
  List<ParkingRegistry> data;
  ParkingException? error;

  RegistryListCubitState({required this.status, this.data = const [], this.error});

  factory RegistryListCubitState.initial() => RegistryListCubitState(status: RegistryListCubitStatus.idle);

  RegistryListCubitState copyWith({RegistryListCubitStatus? status, List<ParkingRegistry>? data, ParkingException? error}) {
    return RegistryListCubitState(
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
      other is RegistryListCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}