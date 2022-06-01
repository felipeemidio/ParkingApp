import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit_state.dart';

class RegistryListTile extends StatelessWidget {
  final ParkingRegistry registry;
  final VoidCallback onChange;

  const RegistryListTile({
    Key? key,
    required this.registry,
    required this.onChange
  }) : super(key: key);

  Future<void> _delete(BuildContext context, RegistryDeleteCubit cubit) async {
    await cubit.delete(registry);
    onChange();
    Navigator.of(context).pop();
  }

  showDeleteDialog(BuildContext context, RegistryDeleteCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete registry?'),
          content: const Text("This action can't be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _delete(context, cubit),
              style: ElevatedButton.styleFrom( primary: Theme.of(context).errorColor),
              child: const Text('Delete'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd().add_Hm();
    return BlocProvider<RegistryDeleteCubit>(
      create: (_) => RegistryDeleteCubit(
          parkingRegistryRepository: GetIt.I.get<ParkingRegistryRepository>()),
      child: ListTile(
        title: Text('Registry ${registry.id.substring(0, 8)}'),
        subtitle: Text('${registry.licensePlate}\n${dateFormat.format(registry.createdAt)} - '
            '${registry.endedAt == null ? 'parked' : dateFormat.format(registry.endedAt!)}'),
        isThreeLine: true,
        trailing: BlocConsumer<RegistryDeleteCubit, RegistryDeleteCubitState>(
          listener: (context, state) {
            if(state.status == RegistryDeleteCubitStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Something went wrong!'),
                  backgroundColor: Theme.of(context).errorColor,
                )
              );
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: state.status == RegistryDeleteCubitStatus.loading
                  ? null
                  : () => showDeleteDialog(context, context.read<RegistryDeleteCubit>()),
              icon: const Icon(Icons.delete_outline, color: Colors.red,),
            );
          }
        ),
      ),
    );
  }
}
