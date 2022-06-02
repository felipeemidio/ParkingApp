import 'package:mocktail/mocktail.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';

class MockDataSource extends Mock implements LocalStorageDatasource {}

class MockParkingRegistryRepository extends Mock implements ParkingRegistryRepository {}

class MockParkingSlotRepository extends Mock implements ParkingSlotRepository {}

class MockParkingSlotUsecase extends Mock implements ParkingSlotUsecase {}

class MockParkingRegistryUsecase extends Mock implements ParkingRegistryUsecase {}