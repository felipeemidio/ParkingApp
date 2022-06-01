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
  Exception? error;

  SlotEditCubitState({required this.status, this.data, this.error});

  factory SlotEditCubitState.initial() => SlotEditCubitState(status: SlotEditCubitStatus.idle);

  SlotEditCubitState copyWith({SlotEditCubitStatus? status, ParkingSlot? data, Exception? error}) {
    return SlotEditCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}