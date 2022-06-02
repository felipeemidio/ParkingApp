import 'package:flutter_test/flutter_test.dart';
import 'package:parking/domain/models/parking_registry.dart';

import '../../mocks/data.dart';

main() {
  test('Create ParkingRegistry from map', () {
    final map = {
      'id': 'SomeRandomId',
      'slotId': 'slotA',
      'licensePlate': 'ABC-123',
      'observations': 'Nothing.',
      'createdAt': '2022-02-02',
      'endedAt': null,
    };

    final registry = ParkingRegistry.fromMap(map);

    expect(registry.id, map['id']);
    expect(registry.slotId, map['slotId']);
    expect(registry.createdAt, isA<DateTime>());
    expect(registry.observations, map['observations']);
    expect(registry.licensePlate, map['licensePlate']);
    expect(registry.endedAt, map['endedAt']);
  });

  test('Create ParkingRegistry from copyWith', () {
    const newPlate = 'AAA-9999';
    final registry = mockParkingRegistry.copyWith(licensePlate: newPlate);

    expect(registry.id, mockParkingRegistry.id);
    expect(registry.slotId, mockParkingRegistry.slotId);
    expect(registry.licensePlate, newPlate);
  });

  test('ParkingRegistry as map', () {
    final map = mockParkingRegistry.toMap();

    expect(map['id'], mockParkingRegistry.id);
    expect(map['slotId'], mockParkingRegistry.slotId);
    expect(map['createdAt'], mockParkingRegistry.createdAt.toIso8601String());
    expect(map['observations'], mockParkingRegistry.observations);
    expect(map['licensePlate'], mockParkingRegistry.licensePlate);
    expect(map['endedAt'], mockParkingRegistry.endedAt);
  });
}