import 'package:flutter/material.dart';
import 'package:ketto_quote/NetworkHandler/NetworkHandler.dart';
import 'package:ketto_quote/Quote.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<NetworkHandler>(
          create: (context) => NetworkHandler(),
          builder: (context, child) {
            return Quote();
          }),
    );
  }
}

