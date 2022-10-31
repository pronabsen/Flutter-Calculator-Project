
import 'package:equatable/equatable.dart';

import '../model/calculation_model.dart';

abstract class CalculationState extends Equatable {
  final CalculationModel calculationModel;
  final List<CalculationModel> history;

  const CalculationState({
    required this.calculationModel,
    required this.history,
  });

  @override
  List<Object> get props => [calculationModel, history];
}

class CalculationInitial extends CalculationState {
  CalculationInitial()
      : super(calculationModel: const CalculationModel(), history: []);
}

class CalculationChanged extends CalculationState {
  const CalculationChanged({
    required CalculationModel calculationModel,
    required List<CalculationModel> history,
  }) : super(
          calculationModel: calculationModel,
          history: history,
        );
}
