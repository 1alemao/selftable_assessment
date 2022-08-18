import 'package:cat_holder/models/user.dart';
import 'package:cat_holder/services/database.dart';
import 'package:cat_holder/views/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Will be using the Provider for handling database changes on this assessment
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CatHolderDatabase(),
        ),
        ChangeNotifierProvider(
          create: (_) => User(),
        )
      ],
      child: const CatHolder(),
    ),
  );
}

class CatHolder extends StatelessWidget {
  const CatHolder({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Holder',
      // Basic theme configuration to better represent the Figma mock
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const CatHolderScaffold(),
    );
  }
}
