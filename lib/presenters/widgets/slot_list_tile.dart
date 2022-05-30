import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_slot.dart';

class SlotListTile extends StatelessWidget {
  final ParkingSlot slot;
  final VoidCallback onClickAction;

  const SlotListTile({Key? key, required this.slot, required this.onClickAction}) : super(key: key);

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
              onPressed: onClickAction,
              icon: slot.currentRegistry == null
                  ? const Icon(Icons.login, color: Colors.green,)
                  : const Icon(Icons.logout, color: Colors.orangeAccent,),
            ),
          ],
        ),
      ),
    );
  }
}
