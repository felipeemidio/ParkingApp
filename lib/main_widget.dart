import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_slot.dart';
import 'package:parking/presenters/pages/home_page.dart';
import 'package:parking/presenters/pages/slot_detail_page.dart';

import 'domain/consts/routes.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.slotDetail: (context) => SlotDetailPage(
          parkingSlot: ModalRoute.of(context)!.settings.arguments as ParkingSlot,
        ),
      },
    );
  }
}