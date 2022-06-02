import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_slot.dart';

enum SlotEditCubitStatus {
  idle,
  loading,
  error,
  success,
}

class SlotEditCubitState {
  SlotEditCubitStatus status;
  ParkingSlot? data;
  ParkingException? error;

  SlotEditCubitState({required this.status, this.data, this.error});

  factory SlotEditCubitState.initial() => SlotEditCubitState(status: SlotEditCubitStatus.idle);

  SlotEditCubitState copyWith({SlotEditCubitStatus? status, ParkingSlot? data, ParkingException? error}) {
    return SlotEditCubitState(
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
      other is SlotEditCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}