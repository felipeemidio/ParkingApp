import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/presenters/cubits/slot_list_cubit.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockSlotUsecase = MockParkingSlotUsecase();

  blocTest<SlotListCubit, SlotListCubitState>(
    'fetch list of ParkingSlots',
    build: () {
      when(() => mockSlotUsecase.getAll(withRegistries: true)).thenAnswer((_) async => mockParkingSlots);

      return SlotListCubit(parkingSlotUsecase: mockSlotUsecase);
    },
    act: (cubit) => cubit.fetch(),
    expect: () => <SlotListCubitState>[
      SlotListCubitState(status: SlotListCubitStatus.loading),
      SlotListCubitState(status: SlotListCubitStatus.success, data: mockParkingSlots),
    ]
  );

  blocTest<SlotListCubit, SlotListCubitState>(
      'fetch list of ParkingSlots throws an exception',
      build: () {
        when(() => mockSlotUsecase.getAll(withRegistries: true)).thenThrow((_) async => UsecaseException(''));

        return SlotListCubit(parkingSlotUsecase: mockSlotUsecase);
      },
      act: (cubit) => cubit.fetch(),
      expect: () => <SlotListCubitState>[
        SlotListCubitState(status: SlotListCubitStatus.loading),
        SlotListCubitState(status: SlotListCubitStatus.error),
      ]
  );
}