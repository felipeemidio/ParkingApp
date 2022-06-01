import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parking/domain/models/parking_registry.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/domain/utils/upper_case_text_formatter.dart';
import 'package:parking/presenters/cubits/registry_edit_cubit.dart';
import 'package:parking/presenters/cubits/registry_edit_cubit_state.dart';

Future<bool?> showEditRegistryDialog(BuildContext context, ParkingRegistry registry) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => EditRegistryDialog(registry: registry),
  );
}

class EditRegistryDialog extends StatefulWidget {
  final ParkingRegistry registry;

  const EditRegistryDialog({Key? key, required this.registry}) : super(key: key);

  @override
  State<EditRegistryDialog> createState() => _EditRegistryDialogState();
}

class _EditRegistryDialogState extends State<EditRegistryDialog> {
  final formKey = GlobalKey<FormState>();
  final plateController = TextEditingController();
  final observationsController = TextEditingController();

  @override
  void initState() {
    plateController.text = widget.registry.licensePlate ?? '';
    observationsController.text = widget.registry.observations ?? '';

    super.initState();
  }

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
      final newRegistry = widget.registry.copyWith(
        licensePlate: plateController.text.trim(),
        observations: observationsController.text.trim(),
      );
      await context.read<RegistryEditCubit>().edit(newRegistry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistryEditCubit>(
      create: (_) => RegistryEditCubit(
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
                    Text('Slot Id: ${widget.registry.slotId.substring(0, 8)}'),
                    const SizedBox(height: 8,),
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
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8,),
                  BlocConsumer<RegistryEditCubit, RegistryEditCubitState>(
                      listener: (context, state) {
                        if(state.status == RegistryEditCubitStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Something went wrong'),
                              backgroundColor: Theme.of(context).errorColor,
                            ),
                          );
                        } else if (state.status == RegistryEditCubitStatus.success) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.status == RegistryEditCubitStatus.loading
                              ? null : () => submit(context),
                          child: const Text('Edit'),
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