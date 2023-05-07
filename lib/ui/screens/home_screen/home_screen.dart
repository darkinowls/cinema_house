import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/features/network/widgets/no_network_sign.dart';
import 'package:cinema_house/ui/screens/home_screen/tabs/movies_tab.dart';
import 'package:cinema_house/ui/screens/home_screen/tabs/settings_tab.dart';
import 'package:cinema_house/ui/screens/home_screen/tabs/my_tickets_tab.dart';
import 'package:cinema_house/ui/screens/login_screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core/locator.dart';
import '../../../features/auth/cubit/auth_cubit.dart';
import '../../../features/movies/data/movies_api.dart';
import '../../../features/movies/repositories/movies_repository.dart';
import '../../../features/user/domain/entities/user_entity.dart';
import '../../../features/user/domain/user_repository.dart';

class HomeScreen extends StatefulWidget {
  final bool hasNetwork;

  const HomeScreen(this.hasNetwork, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [];

  late final List<Widget> innerRoutes;

  @override
  void initState() {
    locator.registerLazySingletonAsync<MoviesRepository>(
            () async {
          UserEntity userEntity = await locator<UserRepository>().getCurrentUser();
          Box<int> favouriteIds = await Hive.openBox<int>("favouriteIds${userEntity.id}");
          return MoviesRepository(locator<MoviesApi>(), favouriteIds);
        });
    _selectedIndex = (widget.hasNetwork) ? 0 : 1;
    innerRoutes = [
      InnerRoute(tab: const MoviesTab(), _navigatorKeys),
      InnerRoute(tab: const MyTicketsTab(), _navigatorKeys),
      InnerRoute(tab: const SettingsTab(), _navigatorKeys),
    ];
    super.initState();
  }

  @override
  void dispose() {
    locator.unregister<MoviesRepository>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigatorKeys[_selectedIndex]
            .currentState!
            .maybePop(); // Pop of nested
        return false;
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is PhoneNumberRequired) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          }
        },
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                fixedColor: Theme.of(context).primaryColor,
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.movie_sharp),
                      label: LocaleKeys.movies.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.qr_code),
                      label: LocaleKeys.myTickets.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.settings),
                      label: LocaleKeys.settings.tr()),
                ],
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
            body: IndexedStack(index: _selectedIndex, children: innerRoutes)),
      ),
    );
  }
}

class InnerRoute extends StatelessWidget {
  // Creates nested routing
  final Widget tab;
  final GlobalKey<NavigatorState> globalKey = GlobalKey();

  InnerRoute(List<GlobalKey> navigatorKeys, {super.key, required this.tab}) {
    navigatorKeys.add(globalKey);
  }

  @override
  Widget build(BuildContext context) => Localizations(
        locale: context.locale,
        delegates: context.localizationDelegates,
        child: HeroControllerScope(
          controller: MaterialApp.createMaterialHeroController(),
          child: Navigator(
              key: globalKey,
              onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                  settings: settings, builder: (BuildContext _) => tab)),
        ),
      );
}
