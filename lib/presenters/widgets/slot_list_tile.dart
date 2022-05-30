import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_slot.dart';

class SlotListTile extends StatelessWidget {
  final ParkingSlot slot;

  const SlotListTile({Key? key, required this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.car_repair),
            Expanded(
              child: Text(slot.name),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.input_rounded, color: Colors.green,),
            ),
          ],
        ),
      ),
    );
  }
}
