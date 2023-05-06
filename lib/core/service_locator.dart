import 'package:get_it/get_it.dart';
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:nakobase/services/repository/auth_repo_impl.dart';
import 'package:nakobase/services/repository/interfaces/auth_repo.dart';
import 'package:nakobase/services/repository/interfaces/profile_repo.dart';
import 'package:nakobase/services/repository/profile_repo_impl.dart';
import 'package:nakobase/services/supabase_service.dart';

GetIt injector = GetIt.instance;

Future setUpDependencies() async{
    injector.registerLazySingleton<SupabaseServiceContract>(() => SupabaseServiceImp());
    injector.registerSingleton<AuthRepositoryInterface>(AuthRepositoryImpl());
    injector.registerSingleton<ProfileRepositoryInterface>(ProfileRepositoryImpl());
}

final supabaseService = injector.get<SupabaseServiceContract>();
final authRepository = injector.get<AuthRepositoryInterface>();
final profileRepository = injector.get<ProfileRepositoryInterface>();
