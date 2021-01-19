import 'dart:convert';

import 'package:flutter/foundation.dart';

class Variable {
  final String name;
  final String description;
  final int weight;
  final Map<String, int> notUnswer;
  final List<int> validValues;
  final VariableType variableType;

  Variable(
      {this.name,
      this.description = '',
      this.weight = 1,
      this.notUnswer = const {'Отсутствие ответа': -1, 'Отказ от отваета': -7},
      this.validValues = const [],
      this.variableType = VariableType.number});

  Variable copyWith({
    String name,
    String description,
    int weight,
    Map<String, int> notUnswer,
    List<int> validValues,
    VariableType variableType,
  }) {
    return Variable(
      name: name ?? this.name,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      notUnswer: notUnswer ?? this.notUnswer,
      validValues: validValues ?? this.validValues,
      variableType: variableType ?? this.variableType,
    );
  }

  @override
  String toString() {
    return 'Variable(name: $name, description: $description, weight: $weight, notUnswer: $notUnswer, validValues: $validValues, variableType: $variableType)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Variable &&
        o.name == name &&
        o.description == description &&
        o.weight == weight &&
        mapEquals(o.notUnswer, notUnswer) &&
        listEquals(o.validValues, validValues) &&
        o.variableType == variableType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        weight.hashCode ^
        notUnswer.hashCode ^
        validValues.hashCode ^
        variableType.hashCode;
  }
}

enum VariableType { string, number, selection }
