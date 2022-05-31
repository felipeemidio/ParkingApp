import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:parking/domain/repositories/parking_registry_repository.dart';
import 'package:parking/domain/repositories/parking_slot_repository.dart';
import 'package:parking/presenters/cubits/slot_list_cubit.dart';
import 'package:parking/presenters/pages/registries_list_view.dart';
import 'package:parking/presenters/pages/slots_list_view.dart';
import 'package:parking/presenters/widgets/dialogs/create_slot_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SlotListCubit>(
      create: (_) => SlotListCubit(
        parkingSlotRepository: GetIt.I.get<ParkingSlotRepository>(),
        parkingRegistryRepository: GetIt.I.get<ParkingRegistryRepository>(),
      )..fetch(),
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
            setState(() { currentPage = pageIndex;});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.space_bar), label: 'Slots'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historic'),
          ],
        ),
        body: SafeArea(
          child: PageView(
            onPageChanged: (page) {
              setState(() {currentPage = page;});
            },
            controller: controller,
            children: [
              SlotListView(createSlot: _createSlot),
              const RegistriesListView(),
            ],
          ),
        ),
      ),
    );
  }
}