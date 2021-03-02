import 'package:desafio_gas/choose_reseller_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desafio Gás',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              centerTitle: false,
              textTheme: Theme.of(context).primaryTextTheme.copyWith(
                    headline6: Theme.of(context).primaryTextTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
            ),
      ),
      home: ChooseResellerPage(),
    );
  }
}
