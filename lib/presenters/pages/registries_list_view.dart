import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/usecases/parking_registry_usecase.dart';
import 'package:parking/presenters/cubits/registry_list_cubit.dart';
import 'package:parking/presenters/cubits/registry_list_cubit_state.dart';
import 'package:parking/presenters/widgets/registry_list_tile.dart';

class RegistriesListView extends StatelessWidget {
  final void Function(BuildContext context) refreshListSlots;

  const RegistriesListView({Key? key, required this.refreshListSlots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistryListCubit>(
      create: (_) => RegistryListCubit(
          parkingRegistryUsecase: GetIt.I.get<ParkingRegistryUsecase>())..fetch(),
      child: BlocConsumer<RegistryListCubit, RegistryListCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state.status == RegistryListCubitStatus.loading || state.status == RegistryListCubitStatus.idle) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state.status == RegistryListCubitStatus.error) {
            return const Center(
              child: Text("Oops! Something went wrong, contact our support please."),
            );
          }

          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return RegistryListTile(
                registry: state.data[index],
                onChange: () {
                  context.read<RegistryListCubit>().fetch();
                  refreshListSlots(context);
                },
              );
            },
          );
        }
      ),
    );
  }
}
