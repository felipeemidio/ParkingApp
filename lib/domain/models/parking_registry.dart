
class ParkingRegistry {
  final String id;
  final String slotId;
  final DateTime createdAt;
  String? licensePlate;
  String? observations;
  DateTime? endedAt;

  ParkingRegistry({
    required this.id,
    required this.licensePlate,
    required this.createdAt,
    required this.slotId,
    this.observations,
    this.endedAt,
  });

  void exit() {
    endedAt = DateTime.now();
  }

  factory ParkingRegistry.fromMap(Map<String, dynamic> map) {
    return ParkingRegistry(
      id: map['id'],
      slotId: map['slotId'],
      licensePlate: map['licensePlate'],
      createdAt: DateTime.parse(map['createdAt'] as String),
      endedAt: map['endedAt'] != null ? DateTime.parse(map['endedAt'] as String) : null,
      observations: map['observations'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slotId': slotId,
      'licensePlate': licensePlate,
      'createdAt': createdAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'observations': observations,
    };
  }
}