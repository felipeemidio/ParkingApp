import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/presenters/cubits/slot_create_cubit.dart';
import 'package:parking/presenters/cubits/slot_create_cubit_state.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockSlotUsecase = MockParkingSlotUsecase();

  setUpAll(() {
    registerFallbackValue(mockParkingSlot);
  });

  blocTest<SlotCreateCubit, SlotCreateCubitState>(
      'edit ParkingSlots',
      build: () {
        when(() => mockSlotUsecase.save(any())).thenAnswer((_) async => mockParkingSlot);

        return SlotCreateCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.save('SomeName'),
      expect: () => <SlotCreateCubitState>[
        SlotCreateCubitState(status: SlotCreateCubitStatus.loading),
        SlotCreateCubitState(status: SlotCreateCubitStatus.success),
      ]
  );

  blocTest<SlotCreateCubit, SlotCreateCubitState>(
      'edit ParkingSlots throws an exception',
      build: () {
        when(() => mockSlotUsecase.save(any())).thenThrow((_) async => UsecaseException(''));

        return SlotCreateCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.save('SomeName'),
      expect: () => <SlotCreateCubitState>[
        SlotCreateCubitState(status: SlotCreateCubitStatus.loading),
        SlotCreateCubitState(status: SlotCreateCubitStatus.error),
      ]
  );
}