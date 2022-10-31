import 'package:calculator/model/calculation_model.dart';
import 'package:flutter/material.dart';

class CalculationHistory extends StatelessWidget {
   CalculationHistory({Key? key, required this.calculations, required this.title}) : super(key: key);

  final List<CalculationModel> calculations;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
        ],
      ),
      body: Container(
      //  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        //  boxShadow: [
        // //   BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, color: Colors.black12)
        //  ],
        ),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            for (var model in calculations)
              ListTile(
                title: Text(
                  '${model.firstOperand} ${model.operator} ${model.secondOperand} = ${model.result}',
                  textAlign: TextAlign.start,style: TextStyle(fontSize: 20),
                ),
                leading: Icon(Icons.calculate),
              )

          ],
        ),
      ),
    );
  }
}
