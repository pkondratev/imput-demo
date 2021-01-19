import 'package:flutter/foundation.dart';

import 'package:imputation_demo/models/variable.model.dart';

class ImputGroup {
  String name;
  bool enabled;
  List<Variable> variables;

  ImputGroup({
    this.name,
    this.enabled,
    this.variables,
  });

  ImputGroup copyWith({
    String name,
    bool enabled,
    List<Variable> variables,
  }) {
    return ImputGroup(
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
      variables: variables ?? this.variables,
    );
  }

  @override
  String toString() =>
      'ImputGroup(name: $name, enabled: $enabled, variables: $variables)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImputGroup &&
        o.name == name &&
        o.enabled == enabled &&
        listEquals(o.variables, variables);
  }

  @override
  int get hashCode => name.hashCode ^ enabled.hashCode ^ variables.hashCode;
}
