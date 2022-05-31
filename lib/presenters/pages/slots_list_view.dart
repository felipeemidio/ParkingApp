import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/presenters/cubits/slot_list_cubit.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';
import 'package:parking/presenters/widgets/slot_list_tile.dart';

class SlotListView extends StatelessWidget {
  final void Function(BuildContext) createSlot;
  const SlotListView({Key? key, required this.createSlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlotListCubit, SlotListCubitState>(
        builder: (context, state) {

          if(state.status == SlotListCubitStatus.error) {
            return const Center(
              child: Text("Oops! Something went wrong, contact our support please."),
            );
          }

          if(state.status != SlotListCubitStatus.success) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state.data.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Let's create some parking slots.", textAlign: TextAlign.center,),
                    const SizedBox(height: 16,),
                    ElevatedButton(
                      onPressed: () => createSlot(context),
                      child: const Text('Create here!'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return SlotListTile(
                slot: state.data[index],
                onChange: () => context.read<SlotListCubit>().fetch(),
              );
            },
          );
        }
    );
  }
}
