import 'package:appointment/screen/addScreen.dart';
import 'package:appointment/model/dataprovider.dart';
import 'package:appointment/screen/appointments.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static final routeName = '/';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Appointments>(context).itemsP;
    final dataD = Provider.of<Appointments>(context).itemsD;
    List<String> patientName = [];
    List<String> doctorName = [];
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
          onPressed: () {
            for (var i = 0; i < data.length; i++) {
              patientName.add(data[i].name.toString());
            }
            for (var i = 0; i < dataD.length; i++) {
              doctorName.add(dataD[i].name.toString());
            }

            print(doctorName);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddAppointment(patientName, doctorName)),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
