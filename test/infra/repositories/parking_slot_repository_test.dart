import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/infra/repositories/parking_slot_repository.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockLocalStorage = MockDataSource();

  group('Repository getAll', () {
    test('getAll data successfully', () async {
      final mockData = mockParkingSlots.map((e) => e.toMap()).toList();
      when(() => mockLocalStorage.getAll(any())).thenAnswer((_) async => mockData);

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.getAll();
      expect(result.length, mockData.length);

    });

    test('getAll data throws an error', () async {
      when(() => mockLocalStorage.getAll(any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() => repository.getAll(), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository get', () {
    test('get data successfully', () async {
      when(() => mockLocalStorage.get(any(), any())).thenAnswer((_) async => mockParkingSlot.toMap());

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.get('someId');
      expect(result.id, mockParkingSlot.id);

    });

    test('get data throws an error', () async {
      when(() => mockLocalStorage.get(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.get('SomeId'), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository save', () {
    test('save data successfully', () async {
      when(() => mockLocalStorage.save(any(), any())).thenAnswer((_) async => mockParkingSlot.toMap());

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.save(mockParkingSlot);
      expect(result.id, mockParkingSlot.id);

    });

    test('save data throws an error', () async {
      when(() => mockLocalStorage.save(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.save(mockParkingSlot), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository save', () {
    test('save data successfully', () async {
      when(() => mockLocalStorage.save(any(), any())).thenAnswer((_) async => mockParkingSlot.toMap());

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.save(mockParkingSlot);
      expect(result.id, mockParkingSlot.id);

    });

    test('save data throws an error', () async {
      when(() => mockLocalStorage.save(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.save(mockParkingSlot), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository edit', () {
    test('edit data successfully', () async {
      when(() => mockLocalStorage.edit(any(), any(), any())).thenAnswer((_) async => mockParkingSlot.toMap());

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.edit(mockParkingSlot);
      expect(result.id, mockParkingSlot.id);

    });

    test('edit data throws an error', () async {
      when(() => mockLocalStorage.edit(any(), any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.edit(mockParkingSlot), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository delete', () {
    test('delete data successfully', () async {
      when(() => mockLocalStorage.delete(any(), any())).thenAnswer((_) async => mockParkingSlot.toMap());

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.delete('someId');
      expect(result.id, mockParkingSlot.id);

    });

    test('delete data throws an error', () async {
      when(() => mockLocalStorage.delete(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingSlotRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.delete('SomeId'), throwsA(isA<DatasourceException>()));
    });
  });
}