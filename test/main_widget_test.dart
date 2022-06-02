// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/usecases/parking_slot_usecase.dart';
import 'package:parking/infra/datasources/local_storage_datasource.dart';
import 'package:parking/infra/repositories/parking_registry_repository.dart';
import 'package:parking/infra/repositories/parking_slot_repository.dart';

import 'package:parking/main.dart';
import 'package:parking/main_widget.dart';

import 'mocks/mocks.dart';



void main() {
  setUpAll(() {
    // Datasource
    getIt.registerSingleton<LocalStorageDatasource>(MockDataSource());

    // repositories
    getIt.registerSingleton<ParkingSlotRepository>(
        ParkingSlotRepositoryImpl(localStorageDatasource: getIt.get<LocalStorageDatasource>()));
    getIt.registerSingleton<ParkingRegistryRepository>(
        ParkingRegistryRepositoryImpl(localStorageDatasource: getIt.get<LocalStorageDatasource>()));

    // usecases
    getIt.registerSingleton<ParkingSlotUsecase>(
      ParkingSlotUsecase(
        parkingSlotRepository: getIt.get<ParkingSlotRepository>(),
        parkingRegistryRepository: getIt.get<ParkingRegistryRepository>(),
      ),
    );
    getIt.registerSingleton<ParkingRegistryUsecase>(
        ParkingRegistryUsecase(parkingRegistryRepository: getIt.get<ParkingRegistryRepository>()));
  });

  testWidgets('Test main widget rendering', (WidgetTester tester) async {
    await tester.pumpWidget(const MainWidget());
    expect(find.byType(MainWidget), findsOneWidget);
  });
}
