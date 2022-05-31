import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/presenters/cubits/registry_list_cubit.dart';
import 'package:parking/presenters/cubits/registry_list_cubit_state.dart';

class RegistriesListView extends StatelessWidget {
  const RegistriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistryListCubit>(
      create: (_) => RegistryListCubit(
          parkingRegistryRepository: GetIt.I.get<ParkingRegistryRepository>())..fetch(),
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
              final registry = state.data[index];
              final dateFormat = DateFormat.yMd().add_Hm();
              return ListTile(
                title: Text('Registry ${registry.id.substring(0, 8)}'),
                subtitle: Text('${registry.licensePlate}\n${dateFormat.format(registry.createdAt)} - '
                    '${registry.endedAt == null ? 'parked' : dateFormat.format(registry.endedAt!)}'),
                isThreeLine: true,
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline, color: Colors.red,),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
