import 'package:parking/domain/models/parking_slot.dart';

enum SlotListCubitStatus {
  idle,
  loading,
  error,
  success,
}

class SlotListCubitState {
  SlotListCubitStatus status;
  List<ParkingSlot> data;
  Exception? error;

  SlotListCubitState({required this.status, this.data = const [], this.error});

  factory SlotListCubitState.initial() => SlotListCubitState(status: SlotListCubitStatus.idle);

  SlotListCubitState copyWith({SlotListCubitStatus? status, List<ParkingSlot>? data, Exception? error}) {
    return SlotListCubitState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}