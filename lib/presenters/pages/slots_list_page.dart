import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_list_cubit.dart';
import 'package:parking/presenters/cubits/slot_list_cubit_state.dart';
import 'package:parking/presenters/widgets/dialogs/create_registry_dialog.dart';
import 'package:parking/presenters/widgets/dialogs/create_slot_dialog.dart';
import 'package:parking/presenters/widgets/slot_list_tile.dart';

class SpacesListPage extends StatefulWidget {
  const SpacesListPage({Key? key}) : super(key: key);

  @override
  State<SpacesListPage> createState() => _SpacesListPageState();
}

class _SpacesListPageState extends State<SpacesListPage> {
  final PageController controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _createSlot(BuildContext context) async {
    final newSlot = await showCreateSlotDialog(context);
    if(newSlot != null) {
      context.read<SlotListCubit>().fetch();
    }
  }

  Future<void> _createRegistry(BuildContext context, ParkingSlot parkingSlot) async {
    final newRegistry = await showCreateRegistryDialog(context, parkingSlot);
    if(newRegistry != null) {
      parkingSlot.currentRegistry = newRegistry;
      context.read<SlotListCubit>().fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SlotListCubit>(
      create: (_) => SlotListCubit(parkingSlotRepository: GetIt.I.get<ParkingSlotRepository>())..fetch(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Parking Slots'),
          centerTitle: false,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => _createSlot(context),
                  icon: const Icon(Icons.add),
                );
              }
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: currentPage,
          onTap: (pageIndex) async {
            controller.animateToPage(pageIndex, curve: Curves.linear, duration: const Duration(milliseconds: 500));
            setState(() {currentPage = pageIndex;});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.space_bar), label: 'Slots'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historic'),
          ],
        ),
        body: SafeArea(
          child: PageView(
            controller: controller,
            children: [
              BlocBuilder<SlotListCubit, SlotListCubitState>(
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
                              onPressed: () => _createSlot(context),
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
                        onClickAction: () => _createRegistry(context, state.data[index]),
                      );
                    },
                  );
                }
              ),
              ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Registry $index'),
                    subtitle: const Text('Sometime'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline, color: Colors.red,),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
