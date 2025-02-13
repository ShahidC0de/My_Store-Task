import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';
import 'package:task/init_dependencies.dart';
import 'package:task/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  initHome();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLoctor<HomeBloc>(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
