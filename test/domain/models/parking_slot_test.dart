import 'package:flutter_test/flutter_test.dart';
import 'package:parking/domain/models/parking_slot.dart';

import '../../mocks/data.dart';

main() {
  test('Create ParkingRegistry from map', () {
    final map = {
      'id': 'SomeRandomId',
      'name': 'slotA',
      'createdAt': '2022-02-02',
    };

    final registry = ParkingSlot.fromMap(map);

    expect(registry.id, map['id']);
    expect(registry.name, map['name']);
    expect(registry.createdAt, isA<DateTime>());
  });

  test('ParkingRegistry as map', () {
    final map = mockParkingSlot.toMap();

    expect(map['id'], mockParkingSlot.id);
    expect(map['name'], mockParkingSlot.name);
    expect(map['createdAt'], mockParkingSlot.createdAt.toIso8601String());
  });
}