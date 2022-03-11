import 'package:get_it/get_it.dart';

import 'navigation_service.dart';
import 'notification_service.dart';
import 'notification_service_impl.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<NotificationService>(
      () => NotificationServiceImpl());
  getIt.registerLazySingleton(() => NavigationService());
}
