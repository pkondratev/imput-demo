import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imputation_demo/cubits/variable.cubit.dart';
import 'package:imputation_demo/pages/variables.page.dart';
import 'package:imputation_demo/services/variable.service.dart';

void main() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<VariableService>(new VariableService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<VariableCubit>(create: (context) => VariableCubit())
        ],
        child: DefaultTabController(
            length: 1,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'Переменные',
                    ),
                  ],
                ),
                title: Text('КОУЖ-2020. Импутация'),
                centerTitle: false,
              ),
              body: TabBarView(
                children: [VariablesPage()],
              ),
            )));
  }
}
