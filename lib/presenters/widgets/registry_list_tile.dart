import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit.dart';
import 'package:parking/presenters/cubits/registry_delete_cubit_state.dart';
import 'package:parking/presenters/widgets/dialogs/delete_dialog.dart';
import 'package:parking/presenters/widgets/dialogs/edit_registry_dialog.dart';

class RegistryListTile extends StatelessWidget {
  final ParkingRegistry registry;
  final VoidCallback onChange;
  final EdgeInsets? margin;

  const RegistryListTile({
    Key? key,
    required this.registry,
    required this.onChange,
    this.margin,
  }) : super(key: key);

  invokeDeleteDialog(BuildContext context, RegistryDeleteCubit cubit) {
    showDeleteDialog(
      context,
      title: 'Delete registry?',
      message: "This action can't be undone.",
      onDelete: () async {
        await cubit.delete(registry);
        onChange();
        Navigator.of(context).pop();
      },
    );
  }

  showDetailDialog(BuildContext context) async {
    final hasEdit = await showEditRegistryDialog(context, registry);
    if(hasEdit ?? false) {
      onChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd().add_Hm();

    return BlocProvider(
      create: (_) => RegistryDeleteCubit(
          parkingRegistryUsecase: GetIt.I.get<ParkingRegistryUsecase>()),
      child: Card(
        elevation: 2,
        margin: margin ?? const EdgeInsets.fromLTRB(20, 8, 20, 4),
        child: InkWell(
          excludeFromSemantics: true,
          onTap: () => showDetailDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Registry ${registry.id.substring(0, 8)}'),
                      const SizedBox(height: 4,),
                      Text(
                        '${registry.licensePlate}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4,),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(text: '${dateFormat.format(registry.createdAt)} - '),
                            TextSpan(
                              text: registry.endedAt == null ? 'parked' : dateFormat.format(registry.endedAt!),
                              style: registry.endedAt == null
                                  ? const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<RegistryDeleteCubit, RegistryDeleteCubitState>(
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
                            : () => invokeDeleteDialog(context, context.read<RegistryDeleteCubit>()),
                        icon: const Icon(Icons.delete_outline, color: Colors.red,),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
