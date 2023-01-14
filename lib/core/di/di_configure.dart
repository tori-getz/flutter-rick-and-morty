import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_configure.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
)
Future<void> configureDependencies() async => getIt.init();
