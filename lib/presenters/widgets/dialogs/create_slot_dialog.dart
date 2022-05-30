import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_create_cubit.dart';
import 'package:parking/presenters/cubits/slot_create_cubit_state.dart';

Future<ParkingSlot?> showCreateSlotDialog(BuildContext context) async {
  return await showDialog<ParkingSlot>(context: context, builder: (context) => const CreateSlotDialog());
}


class CreateSlotDialog extends StatefulWidget {

  const CreateSlotDialog({Key? key}) : super(key: key);

  @override
  State<CreateSlotDialog> createState() => _CreateSlotDialogState();
}

class _CreateSlotDialogState extends State<CreateSlotDialog> {
  final formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  String? isRequired(String? text) {
    if(text == null || text.trim().isEmpty) {
      return 'Required field';
    }
    return null;
  }

  Future<void> submit(BuildContext context) async {
    if(formKey.currentState?.validate() ?? false) {
      await context.read<SlotCreateCubit>().save(inputController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SlotCreateCubit>(
      create: (_) => SlotCreateCubit(
          parkingSlotRepository: GetIt.I.get<ParkingSlotRepository>()),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Builder(
                  builder: (context) {
                    return TextFormField(
                      controller: inputController,
                      validator: isRequired,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submit(context),
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8,),
                  BlocConsumer<SlotCreateCubit, SlotCreateCubitState>(
                    listener: (context, state) {
                      if(state.status == SlotCreateCubitStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Something went wrong'),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      } else if (state.status == SlotCreateCubitStatus.success) {
                        Navigator.of(context).pop(state.data);
                      }

                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status == SlotCreateCubitStatus.loading
                            ? null : () => submit(context),
                        child: const Text('Save'),
                      );
                    }
                  )
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}
