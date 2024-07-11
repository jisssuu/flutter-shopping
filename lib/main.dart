import 'package:flutter/material.dart';
import 'package:flutter_shoppingapp/constants.dart';
import 'package:flutter_shoppingapp/item_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeSharedPreferences();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      home: ItemListPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}