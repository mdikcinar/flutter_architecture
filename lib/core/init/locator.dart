import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../init/auth/auth_service.dart';
import '../init/repository/auth_repository.dart';
import '../init/repository/db_repository.dart';

import 'auth/firebase_auth_service.dart';
import 'database/db_service.dart';
import 'database/firestore_sevice.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirebaseAuthService(FirebaseAuth.instance));
  locator.registerLazySingleton(() => DbRepository());
  locator.registerLazySingleton(() => DbService());
  locator.registerLazySingleton(() => FirestoreServices());
}
