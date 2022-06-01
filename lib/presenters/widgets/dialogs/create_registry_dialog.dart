import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/utils/upper_case_text_formatter.dart';
import 'package:parking/presenters/cubits/registry_create_cubit.dart';
import 'package:parking/presenters/cubits/registry_create_cubit_state.dart';

Future<ParkingRegistry?> showCreateRegistryDialog(BuildContext context, ParkingSlot parkingSlot) async {
  return await showDialog<ParkingRegistry>(
      context: context,
      builder: (context) => CreateRegistryDialog(parkingSlot: parkingSlot),
  );
}

class CreateRegistryDialog extends StatefulWidget {
  final ParkingSlot parkingSlot;

  const CreateRegistryDialog({Key? key, required this.parkingSlot}) : super(key: key);

  @override
  State<CreateRegistryDialog> createState() => _CreateRegistryDialogState();
}

class _CreateRegistryDialogState extends State<CreateRegistryDialog> {
  final formKey = GlobalKey<FormState>();
  final plateController = TextEditingController();
  final observationsController = TextEditingController();

  @override
  void dispose() {
    plateController.dispose();
    observationsController.dispose();
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
      await context.read<RegistryCreateCubit>().save(
        widget.parkingSlot.id,
        plateController.text.trim(),
        observationsController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistryCreateCubit>(
      create: (_) => RegistryCreateCubit(
          parkingRegistryUsecase: GetIt.I.get<ParkingRegistryUsecase>()),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: plateController,
                      validator: isRequired,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [const UpperCaseTextFormatter(), MaskTextInputFormatter(mask: "AAA-####")],
                      decoration: const InputDecoration(
                          label: Text('License Plate'),
                          hintText: 'ABC-1234'
                      ),
                    ),
                    TextFormField(
                      controller: observationsController,
                      maxLength: 255,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submit(context),
                      decoration: const InputDecoration(
                        label: Text('Observations'),
                      ),
                    ),
                  ],
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
                  BlocConsumer<RegistryCreateCubit, RegistryCreateCubitState>(
                      listener: (context, state) {
                        if(state.status == RegistryCreateCubitStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Something went wrong'),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          );
                        } else if (state.status == RegistryCreateCubitStatus.success) {
                          Navigator.of(context).pop(state.data);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.status == RegistryCreateCubitStatus.loading
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