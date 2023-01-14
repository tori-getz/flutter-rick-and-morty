import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:flutter_rick_and_morty/feature/presentation/bloc/character_search_bloc/character_search_bloc.dart';
import 'package:flutter_rick_and_morty/feature/presentation/route_manager.dart';
import 'package:flutter_rick_and_morty/core/di/di_configure.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await di.configureDependencies();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterListCubit>(
            create: (_) => di.getIt<CharacterListCubit>()..loadCharacter()),
        BlocProvider<CharacterSearchBloc>(
            create: (_) => di.getIt<CharacterSearchBloc>()),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ),
        initialRoute: RouteManager.initialRoute,
        debugShowCheckedModeBanner: false,
        routes: RouteManager.routes,
      ),
    );
  }
}
