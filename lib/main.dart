import 'package:appointment/model/Doctor.dart';
import 'package:appointment/model/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/Appointment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Appointments(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Appointments>(context);
    return Container(
      child: Scaffold(
          body: Container(
        height: 400,
        color: Colors.amber,
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            FlatButton(
                onPressed: () => {Provider.of<Appointments>(context).auth()},
                child: Text("presss me")),
            FlatButton(
                onPressed: () =>
                    {Provider.of<Appointments>(context).fetchApointemnts()},
                child: Text("fetch appointments")),
            FlatButton(
                onPressed: () =>
                    {Provider.of<Appointments>(context).fetchPatient()},
                child: Text("fetch patients")),
            FlatButton(
                onPressed: () =>
                    {Provider.of<Appointments>(context).fetchDoctor()},
                child: Text("fetch doctors")),
          ],
        )),
      )),
    );
  }
}
