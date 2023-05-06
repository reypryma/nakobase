import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/data/counter.dart';
import 'package:nakobase/data/language.dart';
import 'package:nakobase/presentations/pages/dashboard_screen.dart';
import 'package:nakobase/presentations/pages/login_page.dart';
import 'package:nakobase/presentations/routes.dart';
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
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
  /*await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );
  */

  await Supabase.initialize(
    url: 'https://floiadiqmoraoncjfzpy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsb2lhZGlxbW9yYW9uY2pmenB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIwMTM0MTgsImV4cCI6MTk5NzU4OTQxOH0.pdCtxqxjxLlQjd-b0gnOaj-oWjDjVO7Xu2UrP1rxF5Y',
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
        ChangeNotifierProvider<MenuDrawerProvider>(create: (_) => MenuDrawerProvider())
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
        home: (!supabaseService.checkSession()) ? const LoginPage(title: LocaleKeys.login) : DashboardScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Counter counter = Counter();

  void _incrementCounter() {
    setState(() {
      counter.incrementCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          InkWell(
            child: TextButton.icon(
              icon: const Icon(Icons.settings, color: scaffoldColorDark),
              onPressed: () async {
                await updateLanguage(context);
                setState(() {

                });
              }, label: Text(getISOLanguageInfo(Localizations.localeOf(context)) ?? 'English', style: textLato(context, 16, blackTrans95),),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.you_pushed_the_button.tr(),
            ),
            Text(
              '${counter.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            AppButtonWidget(
              height: 15,
              text: 'Change To Indonesia',
              focusColor: primaryLight,
              splashColor: primaryLight,
              hoverColor: primaryLight,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
