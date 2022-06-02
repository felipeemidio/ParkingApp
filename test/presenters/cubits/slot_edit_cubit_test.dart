import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/presenters/cubits/slot_edit_cubit.dart';
import 'package:parking/presenters/cubits/slot_edit_cubit_state.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockSlotUsecase = MockParkingSlotUsecase();

  blocTest<SlotEditCubit, SlotEditCubitState>(
      'edit ParkingSlots',
      build: () {
        when(() => mockSlotUsecase.edit(mockParkingSlot, any())).thenAnswer((_) async => mockParkingSlot);

        return SlotEditCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.edit('SomeName', mockParkingSlot),
      expect: () => <SlotEditCubitState>[
        SlotEditCubitState(status: SlotEditCubitStatus.loading),
        SlotEditCubitState(status: SlotEditCubitStatus.success),
      ]
  );

  blocTest<SlotEditCubit, SlotEditCubitState>(
      'edit ParkingSlots throws an exception',
      build: () {
        when(() => mockSlotUsecase.edit(mockParkingSlot, any())).thenThrow((_) async => UsecaseException(''));

        return SlotEditCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.edit('SomeName', mockParkingSlot),
      expect: () => <SlotEditCubitState>[
        SlotEditCubitState(status: SlotEditCubitStatus.loading),
        SlotEditCubitState(status: SlotEditCubitStatus.error),
      ]
  );
}