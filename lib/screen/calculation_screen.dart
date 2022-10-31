import 'package:calculator/screen/calculation_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calculation_bloc.dart';
import '../components/calculation_history_container.dart';
import '../components/calculator_button.dart';
import '../model/calculation_model.dart';
import 'calculation_result_screen.dart';

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);

  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  late double width;

  @override
  void initState() {
    context.read<CalculationBloc>().add(FetchHistory());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculationBloc, CalculationState>(
      builder: (context, CalculationState state) {
        return Container(
          child:  Column(
            children: [
              AppBar(
                title: Text("Calculator"),
                actions: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalculationHistory(title: "Calculation History", calculations: state.history.reversed.toList(),)),
                        );
                      },
                      icon: Icon(Icons.history))
                ],
              ),
              ResultDisplay(
                text: _getDisplayText(state.calculationModel),
              ),
              Container(
                height: 420,
                margin: EdgeInsets.only(top: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  // color: Colors.white,
                ),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _getButton(text: '7', onTap: () => numberPressed(7)),
                        _getButton(text: '8', onTap: () => numberPressed(8)),
                        _getButton(text: '9', onTap: () => numberPressed(9)),
                        _getButton(
                          text: 'x',
                          onTap: () => operatorPressed('*'),
                            backgroundColor: Colors.blue,
                            textColor: Colors.white
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _getButton(text: '4', onTap: () => numberPressed(4)),
                        _getButton(text: '5', onTap: () => numberPressed(5)),
                        _getButton(text: '6', onTap: () => numberPressed(6)),
                        _getButton(
                          text: '/',
                          onTap: () => operatorPressed('/'),
                            backgroundColor: Colors.blue,
                            textColor: Colors.white
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _getButton(text: '1', onTap: () => numberPressed(1)),
                        _getButton(text: '2', onTap: () => numberPressed(2)),
                        _getButton(text: '3', onTap: () => numberPressed(3)),
                        _getButton(
                          text: '+',
                          onTap: () => operatorPressed('+'),
                            backgroundColor: Colors.blue,
                            textColor: Colors.white
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _getButton(
                          text: '=',
                          onTap: calculateResult,
                          backgroundColor: Colors.orange,
                          textColor: Colors.black,
                        ),
                        _getButton(text: '0', onTap: () => numberPressed(0)),
                        _getButton(
                          text: 'C',
                          onTap: clear,
                          backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
                        ),
                        _getButton(
                          text: '-',
                          onTap: () => operatorPressed('-'),
                          backgroundColor: Colors.blue,
                          textColor: Colors.white
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getButton({
    required String text,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  void numberPressed(int number) {
    context.read<CalculationBloc>().add(NumberPressed(number: number));
  }

  void operatorPressed(String operator) {
    context.read<CalculationBloc>().add(OperatorPressed(operator: operator));
  }

  void calculateResult() {
    context.read<CalculationBloc>().add(CalculateResult());
  }

  void clear() {
    context.read<CalculationBloc>().add(ClearCalculation());
  }

  String _getDisplayText(CalculationModel model) {
    if (model.result != null) {
      return '${model.result}';
    }

    if (model.secondOperand != null) {
      return '${model.firstOperand}${model.operator}${model.secondOperand}';
    }

    if (model.operator != null) {
      return '${model.firstOperand}${model.operator}';
    }

    if (model.firstOperand != null) {
      return '${model.firstOperand}';
    }

    return '${model.result ?? 0}';
  }
}
