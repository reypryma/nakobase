import 'package:get_it/get_it.dart';
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/services/repository/auth_repo_impl.dart';
import 'package:nakobase/services/repository/interfaces/auth_repo.dart';
import 'package:nakobase/services/repository/interfaces/profile_repo.dart';
import 'package:nakobase/services/repository/interfaces/task_status_repo.dart';
import 'package:nakobase/services/repository/interfaces/todo_repo.dart';
import 'package:nakobase/services/repository/profile_repo_impl.dart';
import 'package:nakobase/services/repository/task_status_repo_impl.dart';
import 'package:nakobase/services/repository/todo_repo_impl.dart';
import 'package:nakobase/services/supabase_service.dart';

GetIt injector = GetIt.instance;

Future setUpDependencies() async{
    injector.registerLazySingleton<SupabaseServiceContract>(() => SupabaseServiceImp());
    injector.registerSingleton<AuthRepositoryInterface>(AuthRepositoryImpl());
    injector.registerSingleton<ProfileRepositoryInterface>(ProfileRepositoryImpl());
    injector.registerSingleton<TodoRepositoryInterface>(TodoRepositoryImp());
    injector.registerSingleton<TaskStatusRepositoryInterface>(TaskStatusRepositoryImpl());

    injector.registerFactory<TaskStatusProvider>(() => TaskStatusProvider());
    injector.registerFactory<MenuDrawerProvider>(() => MenuDrawerProvider());
}

final supabaseService = injector.get<SupabaseServiceContract>();
final authRepository = injector.get<AuthRepositoryInterface>();
final profileRepository = injector.get<ProfileRepositoryInterface>();
final todoRepository = injector.get<TodoRepositoryInterface>();
final taskStatusRepository = injector.get<TaskStatusRepositoryInterface>();

final taskStatusProvider = injector<TaskStatusProvider>();
final menuDrawerProvider = injector<MenuDrawerProvider>();
