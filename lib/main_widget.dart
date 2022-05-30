import 'package:flutter/material.dart';
import 'package:parking/presenters/pages/slots_list_page.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SpacesListPage(),
    );
  }
}