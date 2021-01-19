import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imputation_demo/cubits/variable.cubit.dart';
import 'package:imputation_demo/models/variable.model.dart';

class VariablesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                onChanged: (val) =>
                    context.read<VariableCubit>().searchVariables(val),
                decoration: InputDecoration(hintText: 'Поиск...'),
              )),
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () =>
                      context.read<VariableCubit>().searchVariables())
            ],
          ),
        ),
        Expanded(
            child: OrientationBuilder(
          builder: (context, orientation) =>
              BlocBuilder<VariableCubit, List<Variable>>(
                  builder: (context, state) => ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) => VariableWidget(
                            variable: state[index],
                            orientation: orientation,
                          ))),
        ))
      ],
    );
  }
}

class VariableWidget extends StatelessWidget {
  final Variable variable;
  final Orientation orientation;

  const VariableWidget({Key key, this.variable, this.orientation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orientation == Orientation.landscape
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) => Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('Имя переменной: '),
                  Expanded(child: Text(variable.name)),
                  Text('Тип: '),
                  Expanded(
                      child: DropdownButtonFormField<VariableType>(
                    value: variable.variableType,
                    items: [
                      DropdownMenuItem(
                        child: Text('Числовая'),
                        value: VariableType.number,
                      ),
                      DropdownMenuItem(
                        child: Text('Текстовая'),
                        value: VariableType.string,
                      ),
                      DropdownMenuItem(
                        child: Text('Выбор'),
                        value: VariableType.selection,
                      )
                    ],
                  )),
                  Text('Вес: '),
                  Expanded(
                      child: TextFormField(
                          initialValue: variable.weight.toString(),
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (text) {
                            if (RegExp(r"(\d+)$").hasMatch(text)) {
                              context.read<VariableCubit>().updateVariable(
                                  variable.name,
                                  variable.copyWith(weight: int.parse(text)));
                            }
                          },
                          validator: (text) => RegExp(r"(\d+)$").hasMatch(text)
                              ? null
                              : 'Вес может содержать только цифры',
                          keyboardType: TextInputType.number))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  variable.description,
                  maxLines: 10,
                ),
              )
            ],
          ),
        ),
      );

  Widget buildMobile(BuildContext context) => Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('Имя переменной: '),
                  Expanded(child: Text(variable.name)),
                ],
              ),
              Row(
                children: [
                  Text('Тип: '),
                  Expanded(
                      child: DropdownButtonFormField<VariableType>(
                    value: variable.variableType,
                    items: [
                      DropdownMenuItem(
                        child: Text('Числовая'),
                        value: VariableType.number,
                      ),
                      DropdownMenuItem(
                        child: Text('Текстовая'),
                        value: VariableType.string,
                      ),
                      DropdownMenuItem(
                        child: Text('Выбор'),
                        value: VariableType.selection,
                      )
                    ],
                  )),
                ],
              ),
              Row(
                children: [
                  Text('Вес: '),
                  Expanded(
                      child: TextFormField(
                          initialValue: variable.weight.toString(),
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (text) {
                            if (RegExp(r"(\d+)$").hasMatch(text)) {
                              context.read<VariableCubit>().updateVariable(
                                  variable.name,
                                  variable.copyWith(weight: int.parse(text)));
                            }
                          },
                          validator: (text) => RegExp(r"(\d+)$").hasMatch(text)
                              ? null
                              : 'Вес может содержать только цифры',
                          keyboardType: TextInputType.number))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                child: Text(
                  variable.description,
                  textAlign: TextAlign.left,
                  maxLines: 10,
                ),
              )
            ],
          ),
        ),
      );
}
