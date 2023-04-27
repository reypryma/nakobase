import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nakobase/data/counter.dart';
import 'package:nakobase/data/language.dart';
import 'package:nakobase/translations/codegen_loader.g.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/translations/supported_locales.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/SupaAppButton.dart';
import 'package:nakobase/utils/extra/text_style.dart';
import 'package:nakobase/utils/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );

  runApp(EasyLocalization(
      supportedLocales: supportedLocales,
      path: "assets/translations",
      fallbackLocale: const Locale("en"),
      assetLoader: const CodegenLoader(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(context),

      //Localication
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
              // margin: EdgeInsets.all(5),
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
