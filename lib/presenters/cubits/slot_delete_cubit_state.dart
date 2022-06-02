import 'package:parking/domain/models/parking_slot.dart';

enum SlotDeleteCubitStatus {
  idle,
  loading,
  error,
  success,
}

class SlotDeleteCubitState {
  SlotDeleteCubitStatus status;
  ParkingSlot? data;
  Exception? error;

  SlotDeleteCubitState({required this.status, this.data, this.error});

  factory SlotDeleteCubitState.initial() => SlotDeleteCubitState(status: SlotDeleteCubitStatus.idle);

  SlotDeleteCubitState copyWith({SlotDeleteCubitStatus? status, ParkingSlot? data, Exception? error}) {
    return SlotDeleteCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SlotDeleteCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}