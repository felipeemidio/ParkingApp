import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockRegistryRepository = MockParkingRegistryRepository();
  final mockSlotRepository = MockParkingSlotRepository();
  final usecase = ParkingSlotUsecase(
    parkingRegistryRepository: mockRegistryRepository,
    parkingSlotRepository: mockSlotRepository
  );

  setUpAll(() {
    registerFallbackValue(mockParkingSlot);
  });

  group('Usecase getAll', () {
    test('getAll data successfully', () async {
      final mockData = mockParkingSlots.map((e) {
        e.currentRegistry = null;
        return e;
      }).toList();

      when(() => mockSlotRepository.getAll()).thenAnswer((_) async => mockData);
      final result = await usecase.getAll();

      expect(result.length, mockParkingSlots.length);
      expect(result[0].currentRegistry, null);
    });

    test('getAll data with registries successfully', () async {
      final mockData = mockParkingSlots.map((e) {
        e.currentRegistry = null;
        return e;
      }).toList();

      when(() => mockSlotRepository.getAll()).thenAnswer((_) async => mockData);
      when(() => mockRegistryRepository.getAllBy(any())).thenAnswer((_) async => mockParkingRegistries);

      final result = await usecase.getAll(withRegistries: true);

      expect(result.length, mockParkingSlots.length);
      expect(result[0].currentRegistry, isA<ParkingRegistry>());
    });

    test('getAll data throws an error', () async {
      when(() => mockSlotRepository.getAll()).thenThrow(RepositoryException('Error'));

      expect(() => usecase.getAll(), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase get', () {
    test('get data successfully', () async {
      when(() => mockSlotRepository.get(any())).thenAnswer((_) async => mockParkingSlot);
      final result = await usecase.get('SomeId');

      expect(result.id, mockParkingSlot.id);
    });

    test('get data throws an error', () async {
      when(() => mockSlotRepository.get(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.get('someId'), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase save', () {
    test('save data successfully', () async {
      when(() => mockSlotRepository.save(any())).thenAnswer((_) async => mockParkingSlot);
      final result = await usecase.save(mockParkingSlot);

      expect(result.id, mockParkingSlot.id);
    });

    test('save data throws an error', () async {
      when(() => mockSlotRepository.save(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.save(mockParkingSlot), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase delete', () {
    test('delete data successfully', () async {
      when(() => mockSlotRepository.delete(any())).thenAnswer((_) async => mockParkingSlot);
      final result = await usecase.delete(mockParkingSlot);

      expect(result.id, mockParkingSlot.id);
    });

    test('delete data throws an error', () async {
      when(() => mockSlotRepository.delete(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.delete(mockParkingSlot), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase edit', () {
    test('edit data successfully', () async {
      when(() => mockSlotRepository.edit(any())).thenAnswer((_) async => mockParkingSlot);
      final result = await usecase.edit(mockParkingSlot, 'SomeName');

      expect(result.id, mockParkingSlot.id);
    });

    test('edit data throws an error', () async {
      when(() => mockSlotRepository.edit(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.edit(mockParkingSlot, 'SomeName'), throwsA(isA<RepositoryException>()));
    });
  });

}