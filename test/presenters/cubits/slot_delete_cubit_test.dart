import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockSlotUsecase = MockParkingSlotUsecase();
  final mockRegistryUsecase = MockParkingRegistryUsecase();

  blocTest<SlotDeleteCubit, SlotDeleteCubitState>(
      'edit ParkingSlots',
      build: () {
        when(() => mockRegistryUsecase.getAllBySlotId(any())).thenAnswer((_) async => []);
        when(() => mockSlotUsecase.delete(mockParkingSlot)).thenAnswer((_) async => mockParkingSlot);

        return SlotDeleteCubit(
          parkingSlotUsecase: mockSlotUsecase,
          parkingRegistryUsecase: mockRegistryUsecase,
        );
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
        when(() => mockRegistryUsecase.getAllBySlotId(any())).thenAnswer((_) async => []);
        when(() => mockSlotUsecase.delete(mockParkingSlot)).thenThrow((_) async => UsecaseException(''));

        return SlotDeleteCubit(
          parkingSlotUsecase: mockSlotUsecase,
          parkingRegistryUsecase: mockRegistryUsecase,
        );
      },
      act: (cubit) => cubit.delete(mockParkingSlot),
      expect: () => <SlotDeleteCubitState>[
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.loading),
        SlotDeleteCubitState(status: SlotDeleteCubitStatus.error),
      ]
  );
}