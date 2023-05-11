import 'package:get_it/get_it.dart';
import 'package:today/data/repositories_impl/auth_repository_impl.dart';
import 'package:today/data/repositories_impl/diary_repository_impl.dart';
import 'package:today/domain/repository/auth_repository.dart';
import 'package:today/domain/auth_usecase.dart';
import 'package:today/domain/diary_usecase.dart';
import 'package:today/domain/repository/diary_repository.dart';

final GetIt getIt = GetIt.instance;

void setupDi() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<AuthUseCase>(AuthUseCase());
  getIt.registerSingleton<DiaryRepository>(DiaryRepositoryImpl());
  getIt.registerSingleton<DiaryUseCase>(DiaryUseCase());
}
