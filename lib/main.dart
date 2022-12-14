import 'package:calculator/screen/calculation_screen.dart';
import 'package:calculator/services/calculation_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/calculation_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(CalculatorApp(sharedPreferences: sharedPreferences));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key, required this.sharedPreferences})
      : super(key: key);

  final SharedPreferences sharedPreferences;

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter basic calculator',
      home: Scaffold(
      //  backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) {
            return CalculationBloc(
              calculationHistoryService: CalculationHistoryService(
                sharedPreferences: widget.sharedPreferences,
              ),
            );
          },
          child:  Calculation(),
        ),
      ),
    );
  }
}
