import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/users_bloc.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';
import 'package:flutter_test_app_eclipse/screens/users_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
      providers: [Provider(create: (context) => DataProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => UsersBloc(context.read<DataProvider>()),
          child: const UsersScreen()),
    );
  }
}
