import 'package:get_it/get_it.dart';
import 'package:today/data/repository/auth_repository.dart';
import 'package:today/data/repository/diary_repository.dart';
import 'package:today/data/repository/impl/auth_repository_impl.dart';
import 'package:today/data/repository/impl/diary_repository_impl.dart';
import 'package:today/domain/auth_usecase.dart';
import 'package:today/domain/diary_usecase.dart';

final GetIt getIt = GetIt.instance;
void setupDi() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<AuthUseCase>(AuthUseCase());
  getIt.registerSingleton<DiaryRepository>(DiaryRepositoryImpl());
  getIt.registerSingleton<DiaryUseCase>(DiaryUseCase());
}
