import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/data/counter.dart';
import 'package:nakobase/data/language.dart';
import 'package:nakobase/presentations/pages/dashboard_screen.dart';
import 'package:nakobase/presentations/pages/login_page.dart';
import 'package:nakobase/presentations/routes.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
import 'package:nakobase/services/providers/profile_provider.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/translations/codegen_loader.g.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/translations/supported_locales.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/SupaAppButton.dart';
import 'package:nakobase/utils/extra/text_style.dart';
import 'package:nakobase/utils/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  ).then((value) => setUpDependencies());

  // setUpDependencies();

  // await setUpDependencies();

  runApp(EasyLocalization(
      supportedLocales: supportedLocales,
      path: "assets/translations",
      fallbackLocale: const Locale("en"),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuDrawerProvider>(create: (_) => menuDrawerProvider),
        ChangeNotifierProvider<TaskStatusProvider>(create: (_) => TaskStatusProvider()),
        ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: buildLightTheme(context),

        //Localication
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        routes: Routes.getAll(),
        home: (!supabaseService.checkAuthUser()) ? const LoginPage(title: LocaleKeys.login) : DashboardScreen(),
      ),
    );
  }
}
