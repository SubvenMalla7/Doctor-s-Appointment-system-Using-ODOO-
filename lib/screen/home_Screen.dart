import 'package:appointment/model/dataprovider.dart';
import 'package:appointment/screen/appointments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static final routeName = '/';
  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Appointments>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.add_circle_outline),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Appointments',
              ),
              Tab(
                text: 'Patients',
              ),
              Tab(text: 'Doctors'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AppointmentScreen(),
            Container(
              child: Center(
                child: Text("second"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Third"),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
    print(doctor);
  }
}
