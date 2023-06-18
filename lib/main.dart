import 'package:app_note/firebase_options.dart';
import 'package:app_note/pref/shared_Controller.dart';
import 'package:app_note/provider/languge_provider.dart';
import 'package:app_note/utils/context_extenssion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedController().initSharedPref();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const  Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider(),),
          ],
          builder: (context, widget)  {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates:AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale:  Locale(Provider.of<LanguageProvider>(context).language),
              theme: context.themData,
              initialRoute: '/launch_screen',
              routes: context.rout,
            );
          },
        );
      },
    );
  }
}