import 'package:cinema_house/features/auth/cubit/auth_cubit.dart';
import 'package:cinema_house/features/lightMode/cubit/light_mode_cubit.dart';
import 'package:cinema_house/ui/screens/home_screen/home_screen.dart';
import 'package:cinema_house/ui/screens/home_screen/tabs/movies_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/screens/login_screen/login_screen.dart';
import 'features/network/cubit/network_cubit.dart';
import 'features/lightMode/widgets/app_theme.dart';
import 'core/locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<NetworkCubit>()),
        BlocProvider.value(
          value: locator<LightModeCubit>(),
        ),
        BlocProvider.value(
          value: locator<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<LightModeCubit, bool>(builder: buildAppWithTheme),
    );
  }

  MaterialApp buildAppWithTheme(BuildContext context, bool state) =>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cinema House',
        theme: appThemes[state],
        initialRoute: (BlocProvider.of<AuthCubit>(context).state is AuthSuccess)
            ? '/home'
            : '/login',
        // named routes
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          // global named routes
        },
      );
}
