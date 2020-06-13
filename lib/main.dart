import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './model/dataprovider.dart';
import './screen/home_Screen.dart';
import './screen/addScreen.dart';

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
          primaryColor: Color.fromRGBO(190, 98, 196, 1),
        ),
        home: MainPage(),
        routes: {
          // AddAppointment.routeName: (ctx) =>
          //     AddAppointment(Provider.of<Appointments>(context).itemsP),
        },
      ),
    );
  }
}
