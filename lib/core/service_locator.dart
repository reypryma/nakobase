import 'package:get_it/get_it.dart';
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:nakobase/services/supabase_service.dart';

GetIt injector = GetIt.instance;

void setUpDependencies(){
    injector.registerLazySingleton<SupabaServiceContract>(() => SupabaseServiceImp());

}

