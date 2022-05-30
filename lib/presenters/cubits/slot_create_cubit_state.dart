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
  Exception? error;

  SlotCreateCubitState({required this.status, this.data, this.error});

  factory SlotCreateCubitState.initial() => SlotCreateCubitState(status: SlotCreateCubitStatus.idle);

  SlotCreateCubitState copyWith({SlotCreateCubitStatus? status, ParkingSlot? data, Exception? error}) {
    return SlotCreateCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}