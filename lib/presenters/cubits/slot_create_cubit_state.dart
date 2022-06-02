import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';

enum SlotCreateCubitStatus {
  idle,
  loading,
  error,
  success,
}

class SlotCreateCubitState {
  SlotCreateCubitStatus status;
  ParkingSlot? data;
  ParkingException? error;

  SlotCreateCubitState({required this.status, this.data, this.error});

  factory SlotCreateCubitState.initial() => SlotCreateCubitState(status: SlotCreateCubitStatus.idle);

  SlotCreateCubitState copyWith({SlotCreateCubitStatus? status, ParkingSlot? data, ParkingException? error}) {
    return SlotCreateCubitState(
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
      other is SlotCreateCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}