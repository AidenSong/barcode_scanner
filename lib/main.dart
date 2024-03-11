import 'package:barcode_scanner/page/my_home_page.dart';
import 'package:flutter/material.dart';

enum DetectorViewMode {liveFeed, gallery}

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "바코드 스캐너",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "바코드 스캔 앱"),
    );
  }
}
