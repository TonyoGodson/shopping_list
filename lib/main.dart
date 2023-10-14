import 'package:flutter/material.dart';
import 'package:shopping_list/features/all_lists_screen.dart';

import 'features/new_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AllListsScreen(),
      routes: {
          AllListsScreen.routeName: (BuildContext context) => AllListsScreen(),
          NewListScreen.routeName: (BuildContext context) => NewListScreen(title: "")
      }
      // home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
