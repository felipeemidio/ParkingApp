import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/registry_list_cubit.dart';
import 'package:parking/presenters/cubits/registry_list_cubit_state.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit.dart';
import 'package:parking/presenters/cubits/slot_delete_cubit_state.dart';
import 'package:parking/presenters/cubits/slot_edit_cubit.dart';
import 'package:parking/presenters/widgets/dialogs/delete_dialog.dart';
import 'package:parking/presenters/widgets/registry_list_tile.dart';

class SlotDetailPage extends StatefulWidget {
  final ParkingSlot parkingSlot;

  const SlotDetailPage({Key? key, required this.parkingSlot}) : super(key: key);

  @override
  State<SlotDetailPage> createState() => _SlotDetailPageState();
}

class _SlotDetailPageState extends State<SlotDetailPage> {
  final nameController = TextEditingController();
  bool hasUpdated = false;
  Timer? timer;

  @override
  void initState() {
    nameController.text = widget.parkingSlot.name;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    nameController.dispose();
    super.dispose();
  }

  void updateSlotByTimer(BuildContext context, String text) {
    if(!hasUpdated) {
      hasUpdated = true;
    }

    if(timer?.isActive ?? false) {
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 500), () {
      context.read<SlotEditCubit>().edit(text, widget.parkingSlot);
    });
  }

  invokeDeleteDialog(BuildContext context, SlotDeleteCubit cubit) {
    showDeleteDialog(
      context,
      title: 'Delete parking slot?',
      message: "This action can't be undone.",
      onDelete: () async {
        await cubit.delete(widget.parkingSlot);
        hasUpdated = true;
        Navigator.of(context).pop();
        Navigator.of(context).pop(hasUpdated);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop(hasUpdated);
        }),
        title: Text(widget.parkingSlot.name),
        actions: [
          BlocProvider<SlotDeleteCubit>(
            create: (context) => SlotDeleteCubit(
              parkingSlotRepository: GetIt.I.get<ParkingSlotRepository>(),
            ),
            child: BlocConsumer<SlotDeleteCubit, SlotDeleteCubitState>(
              listener: (context, state) {
                if(state.status == SlotDeleteCubitStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Something went wrong!'),
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () => invokeDeleteDialog(context, context.read<SlotDeleteCubit>()),
                  icon: const Icon(Icons.delete),
                );
              }
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RegistryListCubit>(
              create: (context) => RegistryListCubit(
                parkingRegistryRepository: GetIt.I.get<ParkingRegistryRepository>(),
              )..fetchBySlotId(widget.parkingSlot.id),
            ),
            BlocProvider<SlotEditCubit>(
              create: (context) => SlotEditCubit(
                parkingSlotRepository: GetIt.I.get<ParkingSlotRepository>(),
              ),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Builder(
                builder: (context) {
                  return TextField(
                    controller: nameController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    onChanged: (text) => updateSlotByTimer(context, text),
                  );
                }
              ),
              const SizedBox(height: 16,),
              const Text('Registries'),
              const SizedBox(height: 8,),
              Expanded(
                child: BlocBuilder<RegistryListCubit, RegistryListCubitState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return RegistryListTile(
                          registry: state.data[index],
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                          onChange: () {
                            if(!hasUpdated) {
                              hasUpdated = true;
                            }
                            context.read<RegistryListCubit>()
                                .fetchBySlotId(widget.parkingSlot.id);
                          },
                        );
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
