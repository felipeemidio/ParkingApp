import 'package:parking/domain/exceptions/exceptions.dart';
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
  ParkingException? error;

  SlotListCubitState({required this.status, this.data = const [], this.error});

  factory SlotListCubitState.initial() => SlotListCubitState(status: SlotListCubitStatus.idle);

  SlotListCubitState copyWith({SlotListCubitStatus? status, List<ParkingSlot>? data, ParkingException? error}) {
    return SlotListCubitState(
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
      other is SlotListCubitState &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}