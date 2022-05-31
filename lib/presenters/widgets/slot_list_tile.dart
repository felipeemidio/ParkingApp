import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_close_cubit.dart';
import 'package:parking/presenters/cubits/registry_close_cubit_state.dart';
import 'package:parking/presenters/widgets/dialogs/create_registry_dialog.dart';

class SlotListTile extends StatelessWidget {
  final ParkingSlot slot;
  final VoidCallback onChange;

  const SlotListTile({Key? key, required this.slot, required this.onChange}) : super(key: key);

  Future<void> _createRegistry(BuildContext context, ParkingSlot parkingSlot) async {
    final newRegistry = await showCreateRegistryDialog(context, parkingSlot);
    if(newRegistry != null) {
      parkingSlot.currentRegistry = newRegistry;
      onChange();
    }
  }

  Future<void> _finishRegistry(BuildContext context, ParkingSlot parkingSlot) async {
    final registry = slot.currentRegistry!;
    parkingSlot.currentRegistry = null;
    await context.read<RegistryCloseCubit>().closeRegistry(registry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistryCloseCubit>(
      create: (_) => RegistryCloseCubit(parkingRegistryRepository: GetIt.I.get<ParkingRegistryRepository>()),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<RegistryCloseCubit, RegistryCloseCubitState>(
            builder: (context, state) {
              final bool hasRegistry = slot.currentRegistry != null;
              return Row(
                children: [
                  const Icon(Icons.car_repair),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(slot.name),
                        if(hasRegistry)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${slot.currentRegistry?.licensePlate ?? ''} - ${DateFormat.yMd().add_Hm().format(slot.currentRegistry!.createdAt)}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: hasRegistry
                        ? () => _finishRegistry(context, slot)
                        : () => _createRegistry(context, slot),
                    icon: hasRegistry
                        ? const Icon(Icons.logout, color: Colors.orangeAccent,)
                        : const Icon(Icons.login, color: Colors.green,),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
