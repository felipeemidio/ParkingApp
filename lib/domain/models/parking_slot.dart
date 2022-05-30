import 'package:parking/domain/models/parking_registry.dart';

class ParkingSlot {
  final String id;
  String name;
  DateTime createdAt;
  ParkingRegistry? currentRegistry;

  ParkingSlot({
    required this.id,
    required this.name,
    required this.createdAt,
    this.currentRegistry,
  });

  bool get occupied => currentRegistry != null;

  factory ParkingSlot.fromMap(Map<String, dynamic> map) {
    return ParkingSlot(
      id: map['id'],
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

}