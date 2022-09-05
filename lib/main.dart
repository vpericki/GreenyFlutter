import 'package:flutter/material.dart';
import 'package:greeny_flutter_app/Presentation/Routes/routes_generator.dart';
import 'package:greeny_flutter_app/business_logic/secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Greeny",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
