import 'package:get_it/get_it.dart';

void registerManager<T extends Object>(T instance) {
  final getIt = GetIt.instance;
  getIt.registerSingleton<T>(instance);
}

T getManager<T extends Object>() {
  final getIt = GetIt.instance;
  return getIt<T>();
}

