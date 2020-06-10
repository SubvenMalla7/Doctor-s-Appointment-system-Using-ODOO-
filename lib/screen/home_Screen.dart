
import 'package:appointment/screen/appointments.dart';

import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  static final routeName = '/';
  @override
  Widget build(BuildContext context) {
  
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Appointments"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.add_circle_outline),
            )
          ],
        ),
        body: AppointmentScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
