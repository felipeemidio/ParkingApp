import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/infra/repositories/parking_registry_repository.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockLocalStorage = MockDataSource();

  group('Repository getAll', () {
    test('getAll data successfully', () async {
      final mockData = mockParkingRegistries.map((e) => e.toMap()).toList();
      when(() => mockLocalStorage.getAll(any())).thenAnswer((_) async => mockData);

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.getAll();
      expect(result.length, mockData.length);

    });

    test('getAll data throws an error', () async {
      when(() => mockLocalStorage.getAll(any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() => repository.getAll(), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository get', () {
    test('get data successfully', () async {
      when(() => mockLocalStorage.get(any(), any())).thenAnswer((_) async => mockParkingRegistry.toMap());

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.get('someId');
      expect(result.id, mockParkingRegistry.id);

    });

    test('get data throws an error', () async {
      when(() => mockLocalStorage.get(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.get('SomeId'), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository save', () {
    test('save data successfully', () async {
      when(() => mockLocalStorage.save(any(), any())).thenAnswer((_) async => mockParkingRegistry.toMap());

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.save(mockParkingRegistry);
      expect(result.id, mockParkingRegistry.id);

    });

    test('save data throws an error', () async {
      when(() => mockLocalStorage.save(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.save(mockParkingRegistry), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository save', () {
    test('save data successfully', () async {
      when(() => mockLocalStorage.save(any(), any())).thenAnswer((_) async => mockParkingRegistry.toMap());

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.save(mockParkingRegistry);
      expect(result.id, mockParkingRegistry.id);

    });

    test('save data throws an error', () async {
      when(() => mockLocalStorage.save(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.save(mockParkingRegistry), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository edit', () {
    test('edit data successfully', () async {
      when(() => mockLocalStorage.edit(any(), any(), any())).thenAnswer((_) async => mockParkingRegistry.toMap());

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.edit(mockParkingRegistry);
      expect(result.id, mockParkingRegistry.id);

    });

    test('edit data throws an error', () async {
      when(() => mockLocalStorage.edit(any(), any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.edit(mockParkingRegistry), throwsA(isA<DatasourceException>()));
    });
  });

  group('Repository delete', () {
    test('delete data successfully', () async {
      when(() => mockLocalStorage.delete(any(), any())).thenAnswer((_) async => mockParkingRegistry.toMap());

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      final result = await repository.delete('someId');
      expect(result.id, mockParkingRegistry.id);

    });

    test('delete data throws an error', () async {
      when(() => mockLocalStorage.delete(any(), any())).thenThrow(DatasourceException('Error'));

      final repository = ParkingRegistryRepositoryImpl(
          localStorageDatasource: mockLocalStorage
      );

      expect(() async => await repository.delete('SomeId'), throwsA(isA<DatasourceException>()));
    });
  });
}