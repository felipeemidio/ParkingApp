import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockSlotUsecase = MockParkingSlotUsecase();

  blocTest<SlotDeleteCubit, SlotDeleteCubitState>(
      'edit ParkingSlots',
      build: () {
        when(() => mockSlotUsecase.delete(mockParkingSlot)).thenAnswer((_) async => mockParkingSlot);

        return SlotDeleteCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.delete(mockParkingSlot),
      expect: () => <SlotDeleteCubitState>[
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.loading),
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.success),
      ]
  );

  blocTest<SlotDeleteCubit, SlotDeleteCubitState>(
      'edit ParkingSlots throws an exception',
      build: () {
        when(() => mockSlotUsecase.delete(mockParkingSlot)).thenThrow((_) async => UsecaseException(''));

        return SlotDeleteCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.delete(mockParkingSlot),
      expect: () => <SlotDeleteCubitState>[
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.loading),
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.error),
      ]
  );
}