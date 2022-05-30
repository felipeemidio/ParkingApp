import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/external/datasources/sqlite_local_storage.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';
import 'package:parking/infra/repositories/parking_registry_repository.dart';
import 'package:parking/infra/repositories/parking_slot_repository.dart';
import 'package:parking/main_widget.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<LocalStorageDatasource>(SqliteLocalStorage());

  getIt.registerSingleton<ParkingSlotRepository>(
      ParkingSlotRepositoryImpl(localStorageDatasource: getIt.get<LocalStorageDatasource>()));
  getIt.registerSingleton<ParkingRegistryRepository>(
      ParkingRegistryRepositoryImpl(localStorageDatasource: getIt.get<LocalStorageDatasource>()));
}

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const MainWidget());
}
