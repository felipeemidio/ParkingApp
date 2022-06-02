import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/models/parking_slot.dart';

final mockParkingSlot = ParkingSlot(
  id: 'X',
  name: 'NameX',
  createdAt: DateTime(2022, 12, 2, 12, 30, 44),
  currentRegistry: ParkingRegistry(
    licensePlate: 'YXT-3267',
    id: 'RX',
    slotId: 'A',
    createdAt: DateTime(2022, 12, 2, 20, 10, 11),
    endedAt: null,
  ),
);

final mockParkingSlots = [
  ParkingSlot(
    id: 'A',
    name: 'NameA',
    createdAt: DateTime(2022, 12, 2, 12, 30, 44),
    currentRegistry: ParkingRegistry(
      licensePlate: 'AXS-3267',
      id: 'RA',
      slotId: 'A',
      createdAt: DateTime(2022, 12, 2, 20, 10, 11),
      endedAt: null,
    ),
  ),
  ParkingSlot(
    id: 'B',
    name: 'NameB',
    createdAt: DateTime(2022, 12, 2, 15, 30, 44),
    currentRegistry: ParkingRegistry(
      licensePlate: 'AXP-3223',
      id: 'RB',
      slotId: 'B',
      createdAt: DateTime(2022, 12, 2, 15, 32, 55),
      endedAt: DateTime(2022, 12, 2, 15, 55, 12),
    ),
  ),
  ParkingSlot(id: 'C', name: 'NameC', createdAt: DateTime(2022, 12, 2, 12, 30, 44)),
];

final mockParkingRegistry =  ParkingRegistry(
  licensePlate: 'OVN-1199',
  id: 'RX',
  slotId: 'C',
  createdAt: DateTime(2022, 12, 3, 8, 3, 33),
  endedAt: null,
);

final mockParkingRegistries = [
  ParkingRegistry(
    licensePlate: 'AXP-3223',
    id: 'R1',
    slotId: 'A',
    createdAt: DateTime(2022, 12, 2, 15, 32, 55),
    endedAt: DateTime(2022, 12, 2, 15, 55, 12),
  ),
  ParkingRegistry(
    licensePlate: 'AXT-5632',
    id: 'R2',
    slotId: 'B',
    createdAt: DateTime(2022, 12, 1, 15, 33, 55),
    endedAt: null,
  ),
  ParkingRegistry(
    licensePlate: 'BCF-1135',
    id: 'R3',
    slotId: 'A',
    createdAt: DateTime(2022, 12, 3, 15, 32, 55),
    endedAt: null,
  ),
  ParkingRegistry(
    licensePlate: 'HTU-9089',
    id: 'R4',
    slotId: 'C',
    createdAt: DateTime(2022, 12, 3, 8, 32, 55),
    endedAt: DateTime(2022, 12, 3, 10, 00, 01),
  ),
  ParkingRegistry(
    licensePlate: 'OMG-8973',
    id: 'R5',
    slotId: 'A',
    createdAt: DateTime(2022, 12, 2, 2, 2, 2),
    endedAt: DateTime(2022, 12, 2, 2, 2, 2),
  ),
];