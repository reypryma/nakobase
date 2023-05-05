import 'package:get_it/get_it.dart';
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:nakobase/services/supabase_service.dart';

GetIt injector = GetIt.instance;

Future setUpDependencies() async{
    injector.registerLazySingleton<SupabaServiceContract>(() => SupabaseServiceImp());
}

final supabaseService = injector.get<SupabaServiceContract>();