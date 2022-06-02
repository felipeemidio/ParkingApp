import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/exceptions/exceptions.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';

import '../../mocks/data.dart';
import '../../mocks/mocks.dart';

main() {
  final mockRegistryRepository = MockParkingRegistryRepository();
  final usecase = ParkingRegistryUsecase(parkingRegistryRepository: mockRegistryRepository);

  setUpAll(() {
    registerFallbackValue(mockParkingRegistry);
  });

  group('Usecase getAll', () {
    test('getAll data successfully', () async {
      when(() => mockRegistryRepository.getAll()).thenAnswer((_) async => mockParkingRegistries);
      final result = await usecase.getAll();

      expect(result.length, mockParkingRegistries.length);
      expect(result[0].createdAt.isAfter(result[1].createdAt), true);
    });

    test('getAll data throws an error', () async {
      when(() => mockRegistryRepository.getAll()).thenThrow(RepositoryException('Error'));

      expect(() => usecase.getAll(), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase get', () {
    test('get data successfully', () async {
      when(() => mockRegistryRepository.get(any())).thenAnswer((_) async => mockParkingRegistry);
      final result = await usecase.get('SomeId');

      expect(result.id, mockParkingRegistry.id);
    });

    test('get data throws an error', () async {
      when(() => mockRegistryRepository.get(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.get('someId'), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase save', () {
    test('save data successfully', () async {
      when(() => mockRegistryRepository.save(any())).thenAnswer((_) async => mockParkingRegistry);
      final result = await usecase.save('someId', 'licensePlate', 'observation');

      expect(result.id, mockParkingRegistry.id);
    });

    test('save data throws an error', () async {
      when(() => mockRegistryRepository.save(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.save('someId', 'licensePlate', 'observation'), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase delete', () {
    test('delete data successfully', () async {
      when(() => mockRegistryRepository.delete(any())).thenAnswer((_) async => mockParkingRegistry);
      final result = await usecase.delete(mockParkingRegistry);

      expect(result.id, mockParkingRegistry.id);
    });

    test('delete data throws an error', () async {
      when(() => mockRegistryRepository.delete(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.delete(mockParkingRegistry), throwsA(isA<RepositoryException>()));
    });
  });

  group('Usecase edit', () {
    test('edit data successfully', () async {
      when(() => mockRegistryRepository.edit(any())).thenAnswer((_) async => mockParkingRegistry);
      final result = await usecase.edit(mockParkingRegistry);

      expect(result.id, mockParkingRegistry.id);
    });

    test('edit data throws an error', () async {
      when(() => mockRegistryRepository.edit(any())).thenThrow(RepositoryException('Error'));

      expect(() => usecase.edit(mockParkingRegistry), throwsA(isA<RepositoryException>()));
    });
  });

}