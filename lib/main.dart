import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('id')],
      path: 'assets/translations', // folder untuk .json file
      fallbackLocale: Locale('en'),
      child: PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: context.locale, // penting!
        title: 'My Portofolio',
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black, // <- ini yang penting
          primaryColor: Colors.black, // opsional
          colorScheme: ColorScheme.light(
            background: Colors.black, // opsional
            primary: Colors.black, // ganti sesuai gaya kamu
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black), // pastikan teks hitam
          ),
        ),
        home: HomePage());
  }
}
