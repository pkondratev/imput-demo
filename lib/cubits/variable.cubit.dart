import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imputation_demo/models/variable.model.dart';
import 'package:imputation_demo/services/variable.service.dart';

final getIt = GetIt.instance;

class VariableCubit extends Cubit<List<Variable>> {
  String searchValue = '';

  VariableCubit([List<Variable> state])
      : super(state ?? VariableService.VARIABLES.values.toList());

  Future searchVariables([String searchPattern]) async {
    this.searchValue = searchPattern;
    this.emit(await getIt.get<VariableService>().findVariable(searchPattern));
  }

  Future updateVariable(String name, Variable variable) async {
    await getIt.get<VariableService>().updateVariable(name, variable);
    searchVariables(searchValue);
  }
}
