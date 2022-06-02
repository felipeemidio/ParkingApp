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
  Exception? error;

  RegistryListCubitState({required this.status, this.data = const [], this.error});

  factory RegistryListCubitState.initial() => RegistryListCubitState(status: RegistryListCubitStatus.idle);

  RegistryListCubitState copyWith({RegistryListCubitStatus? status, List<ParkingRegistry>? data, Exception? error}) {
    return RegistryListCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
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