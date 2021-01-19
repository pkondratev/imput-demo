import 'dart:math';

import 'package:imputation_demo/models/variable.model.dart';

class VariableService {
  Future<List<Variable>> findVariable([String searchString]) {
    if (searchString == null || searchString.isEmpty) {
      return Future.value(VARIABLES.values.toList());
    }
    searchString = searchString.toLowerCase();
    return Future.value(VARIABLES.values
        .where((element) =>
            element.name.toLowerCase().contains(searchString) ||
            element.description.toLowerCase().contains(searchString))
        .toList());
  }

  Future<bool> updateVariable(String name, Variable variable) {
    if (!VARIABLES.containsKey(name)) {
      return Future.value(false);
    }
    VARIABLES[name] = variable;
    return Future.value(true);
  }

  static Random random = Random();

  static Map<String, Variable> VARIABLES = {
    'Субъект': Variable(
        name: 'Субъект',
        description: 'Принадложность определенному субъекту РФ',
        notUnswer: {},
        variableType: VariableType.number,
        weight: 4000),
    'ГорСело': Variable(
        name: 'ГорСело',
        description: 'Принадлежность ДХ к городскому или сельскому типу',
        validValues: [0, 1],
        variableType: VariableType.selection,
        weight: 2000)
  }..addAll(_generateVariable(30));

  static Map<String, Variable> _generateVariable(int count) {
    return Map.fromEntries(List.generate(count, (index) {
      var isNumeric = (random.nextInt(4) == 0);
      return MapEntry(
          'H0${index}_0$index',
          Variable(
              name: 'H0${index}_0$index',
              validValues: isNumeric
                  ? null
                  : List.generate(random.nextInt(30), (index) => index),
              variableType:
                  isNumeric ? VariableType.number : VariableType.selection));
    }));
  }
}
